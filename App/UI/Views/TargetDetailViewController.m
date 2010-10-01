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
  _locationManager = nil;
  
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
  [_locationManager release];
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

- (void)didTakePicture:(UIImage *)picture {
  NSLog(@"picture; %@", picture);
  
  if (_locationManager == nil) {
    _locationManager = [[[CLLocationManager alloc] init] retain];
    if ([CLLocationManager locationServicesEnabled] == NO) {
      UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled. If you proceed, you will be asked to confirm whether location services should be reenabled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      [servicesDisabledAlert show];
      [servicesDisabledAlert release];
    }
  }
	_locationManager.delegate = self;
	_locationManager.distanceFilter = 1;
	_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  NSLog(@"Getting location...");
	[_locationManager startUpdatingLocation];
  [self didFinishWithCamera];
}

- (void)didFinishWithCamera {
  [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void) locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation {
	[_locationManager stopUpdatingLocation];
	NSLog(@"%@", [newLocation description]);
  
	NSString *latitude = [NSString stringWithFormat:@"%3.5f", newLocation.coordinate.latitude];
	NSString *longitude = [NSString stringWithFormat:@"%3.5f", newLocation.coordinate.longitude];
	NSLog(@"lat: %@, lon: %@ (acrcy %@)", latitude, longitude, newLocation.horizontalAccuracy);
}

- (void) locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error {
  NSLog(@"Location Error: %@", [error localizedDescription]);
}

@end
