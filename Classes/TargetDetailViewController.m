//
//  TargetDetailViewController.m
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Lumos Labs, Inc. All rights reserved.
//

#import "TargetDetailViewController.h"
#import "Target.h"
#import "TargetsModel.h"
#import "OverlayViewController.h"
#import "EOLocationProvider.h"
#import "Photo.h"

@interface  TargetDetailViewController () 
- (IBAction) cameraButtonTapped:(id)sender;
@end

@implementation TargetDetailViewController

@synthesize target = _target;
@synthesize overlayViewController = _overlayViewController;

- (id) initWithSlug:(NSString*)slug {
  if ((self=[super init])) {
    Target* target = [[TargetsModel sharedInstance] targetForSlug:slug];
    self.target = target;
    self.title = self.target.name;
    self.tableViewStyle = UITableViewStyleGrouped;
  }
  return self;
}

#pragma mark TTModelViewController

- (void) createModel {
  NSArray* sectionArray = [[NSArray alloc] initWithObjects:@"Photos", nil];
  NSMutableArray* photosSectionArray = [[NSMutableArray alloc] init];
  
  [photosSectionArray addObject:[TTTableButton itemWithText:@"Take new photo" delegate:self selector:@selector(cameraButtonTapped:)]];
  if ([self.target.photos count]>0) {
    Photo* photo = [self.target.photos lastObject];
    
    NSString* labelText = [NSString stringWithFormat:@"%d Photos", [self.target.photos count]];
    NSString* imageURL = [photo URLForVersion:TTPhotoVersionThumbnail];
    NSString* viewURL = [self.target URLValueWithName:@"photosView"];
    NSLog(@"Most Recent Image URL: %@", imageURL);
    TTTableImageItem* imageItem = [TTTableImageItem itemWithText:labelText imageURL:imageURL URL:viewURL];
    [photosSectionArray addObject:imageItem];
  }
    
  NSArray* itemsArray = [[NSArray alloc] initWithObjects:photosSectionArray, nil];
  
  self.dataSource = [TTSectionedDataSource dataSourceWithItems:itemsArray sections:sectionArray];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.overlayViewController = [[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:nil];
  self.overlayViewController.delegate = self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
  self.overlayViewController = nil;
  [super viewDidUnload];
}


- (void)dealloc {
  [_overlayViewController release];
  [super dealloc];
}

#pragma mark -

- (IBAction) cameraButtonTapped:(id)sender {
  NSLog(@"tapped");
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [self.overlayViewController setupImagePicker];
    [self presentModalViewController:self.overlayViewController.imagePickerController animated:YES];
  }
}

#pragma mark -
#pragma mark OverlayViewControllerDelegate

- (NSString*) saveNameForImage:(UIImage*)image named:(NSString*)name {
  NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString* filename = [NSString stringWithFormat:@"%@-%@.jpg", name, [NSDate date]];
  NSString* path = [NSString stringWithFormat:@"%@/%@", documentsDirectory, filename];
  NSLog(@"file path: %@", path);
  if([imageData writeToFile:path atomically:YES]) {
    return filename;
  }
  return nil;
}

- (void) didTakePicture:(UIImage*)picture {
  NSLog(@"picture: %dx%d %@", (int)picture.size.width, (int)picture.size.height, picture);
  NSLog(@"Picture location = %@", [EOLocationProvider sharedInstance].lastLocation);
  
  BOOL needsRotation = (picture.size.width > picture.size.height);
  UIImage* fullImage = [picture transformWidth:320 height:480 rotate:needsRotation];
  NSString* filename = [self saveNameForImage:fullImage named:self.target.name];
  if (filename) {
    UIImage* thumbnailImage = [picture transformWidth:50 height:50 rotate:needsRotation];
    NSString* thumbnailName = [NSString stringWithFormat:@"%@-thumb", self.target.name];
    NSString* thumbnailFilename = [self saveNameForImage:thumbnailImage named:thumbnailName];
    if (thumbnailFilename) {
      NSString* fileURL = [NSString stringWithFormat:@"documents://%@", filename];
      NSString* thumbnailURL = [NSString stringWithFormat:@"documents://%@", thumbnailFilename];
      Photo* photo = [[Photo alloc] initWithURL:fileURL smallURL:thumbnailURL size:fullImage.size];
      NSLog(@"Photo: %@", photo);
      [self.target addPhoto:photo];
    }
  }

  [self didFinishWithCamera];
}

- (void)didFinishWithCamera {
  [self dismissModalViewControllerAnimated:YES];
}

@end
