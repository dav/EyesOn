//
//  TargetDetailViewController.m
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Lumos Labs, Inc. All rights reserved.
//

#import "TargetDetailViewController.h"
#import "Target.h"
#import "OverlayViewController.h"

@implementation TargetDetailViewController

@synthesize target = _target;
@synthesize overlayViewController = _overlayViewController;

- (void)viewDidLoad {
  [super viewDidLoad];
  if (self.target) self.title = self.target.name;
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

- (IBAction) cameraButtonTapped:(id)sender {
  NSLog(@"tapped");
  [self.overlayViewController setupImagePicker];
  [self presentModalViewController:self.overlayViewController.imagePickerController animated:YES];
}

#pragma mark -
#pragma mark OverlayViewControllerDelegate

- (void)didTakePicture:(UIImage *)picture {
  NSLog(@"picture; %@", picture);
}

- (void)didFinishWithCamera {
  [self dismissModalViewControllerAnimated:YES];
}


@end
