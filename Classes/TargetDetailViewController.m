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

@interface  TargetDetailViewController (PrivateMethods) 
- (void) displayPhoto:(Photo*)photo;
@end

@implementation TargetDetailViewController

@synthesize target = _target;
@synthesize overlayViewController = _overlayViewController;
@synthesize lastLocation = _lastLocation;

- (id) initWithSlug:(NSString*)slug {
  if (self = [super init]) {
    Target* target = [[TargetsModel sharedInstance] targetForSlug:slug];
    self.target = target;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  if (self.target) self.title = self.target.name;
  if (self.target.photos) {
    Photo* photo = [self.target.photos lastObject];
    if (photo) {
      [self displayPhoto:photo];
    }
  }
  [cameraButton setTitle:@"Take a photo" forState:UIControlStateNormal];
  
  self.overlayViewController = [[[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:nil] autorelease];
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

- (void) displayPhoto:(Photo*)photo {
  NSString* urlString = [photo URLForVersion:TTPhotoVersionLarge];
  NSLog(@"Displaying Photo from %@", urlString);
  NSData* imageData = nil;
  if ([urlString hasPrefix:@"file://"]) {
    imageData = [NSData dataWithContentsOfFile:[urlString substringFromIndex:7]];
  } else {
    NSURL* url = [NSURL URLWithString:urlString];
    NSError* error = nil;
    imageData = [NSData dataWithContentsOfURL:url options:NSDataReadingMapped error:&error];
    if (error) {
      NSLog(@"ERROR: %@", [error localizedDescription]);
    }
  }
  UIImage* image =[UIImage imageWithData:imageData];
  mainImageView.image = image;
}

- (IBAction) cameraButtonTapped:(id)sender {
  NSLog(@"tapped");
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [self.overlayViewController setupImagePicker];
    [self presentModalViewController:self.overlayViewController.imagePickerController animated:YES];
  }
}

#pragma mark -
#pragma mark OverlayViewControllerDelegate

- (void)didTakePicture:(UIImage *)picture {
  NSLog(@"picture; %@", picture);
  NSLog(@"Picture location = %@", [EOLocationProvider sharedInstance].lastLocation);
  
  NSData *imageData = UIImageJPEGRepresentation(picture, 1.0);
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
  
  NSString *tmpPathToFile = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@-%@.jpg", documentsDirectory, self.target.name, [NSDate date]]];
  NSLog(@"file path: %@", tmpPathToFile);
  
  if([imageData writeToFile:tmpPathToFile atomically:YES]) {
    NSString* fileURL = [NSString stringWithFormat:@"file://%@", tmpPathToFile];
    Photo* photo = [[Photo alloc] initWithURL:fileURL smallURL:fileURL size:picture.size];
    NSLog(@"Photo: %@", photo);
    [self.target addPhoto:photo];
    [self displayPhoto:photo];
  }  
  [self didFinishWithCamera];
}

- (void)didFinishWithCamera {
  [self dismissModalViewControllerAnimated:YES];
}

@end
