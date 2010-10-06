#import "OverlayViewController.h"

@implementation OverlayViewController

@synthesize delegate;
@synthesize takePictureButton;
@synthesize cancelButton;
@synthesize imagePickerController;

#pragma mark -
#pragma mark OverlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tick" ofType:@"aiff"]], &tickSound);
    self.imagePickerController = [[[UIImagePickerController alloc] init] autorelease];
    self.imagePickerController.delegate = self;
  }
  return self;
}

- (void)viewDidUnload {
  self.takePictureButton = nil;
  self.cancelButton = nil;
}

- (void)dealloc {   
  [takePictureButton release];
  [cancelButton release];
  
  [imagePickerController release];
  AudioServicesDisposeSystemSoundID(tickSound);
  
  [super dealloc];
}

- (void)setupImagePicker {
  self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
  self.imagePickerController.showsCameraControls = YES;
  if (NO && self.imagePickerController.cameraOverlayView != self.view) {
    CGRect overlayViewFrame = self.imagePickerController.cameraOverlayView.frame;
    CGRect newFrame = CGRectMake(0.0f, 
                                 CGRectGetHeight(overlayViewFrame) - self.view.frame.size.height - 9.0f,
                                 CGRectGetWidth(overlayViewFrame),
                                 self.view.frame.size.height + 9.0f);
    self.view.frame = newFrame;
    self.imagePickerController.cameraOverlayView = self.view;
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)finishAndUpdate {
  [self.delegate didFinishWithCamera];
  
  // restore the state of our overlay toolbar buttons
  self.cancelButton.enabled = YES;
  self.takePictureButton.enabled = YES;
}


#pragma mark -
#pragma mark Camera Actions

- (IBAction)done:(id)sender {
  [self finishAndUpdate];
}

- (IBAction)takePhoto:(id)sender {
  [self.imagePickerController takePicture];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
  if (self.delegate) [self.delegate didTakePicture:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self.delegate didFinishWithCamera];
}

@end
