//
//  EOLocationProvider.m
//  EyesOn
//
//  Created by dav on 10/2/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import "EOLocationProvider.h"


@implementation EOLocationProvider

#pragma mark -

static EOLocationProvider* sharedInstance = nil;

+ (EOLocationProvider*)sharedInstance {
  @synchronized(self) {
    if (sharedInstance == nil) {
			sharedInstance = [[EOLocationProvider alloc] init];
    }
  }  
  return sharedInstance;
}

#pragma mark -

@synthesize lastLocation = _lastLocation;

- (id) init {
  if ((self = [super init])) {
    _locationManager = [[[CLLocationManager alloc] init] retain];
    if ([CLLocationManager locationServicesEnabled] == NO) {
      UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled. If you proceed, you will be asked to confirm whether location services should be reenabled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      [servicesDisabledAlert show];
      [servicesDisabledAlert release];
    }
    _locationManager.delegate = self;
    _locationManager.distanceFilter = 1;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    NSLog(@"Getting location...");
    [_locationManager startUpdatingLocation];
  }
  return self;
}

- (void)dealloc {
  [_locationManager release];
  [super dealloc];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void) locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation {
  if (!self.lastLocation || [newLocation.timestamp compare:self.lastLocation.timestamp]==NSOrderedDescending) {
    [_locationManager stopUpdatingLocation];
    NSLog(@"%@", [newLocation description]);
    NSString* latitude = [NSString stringWithFormat:@"%3.5f", newLocation.coordinate.latitude];
    NSString* longitude = [NSString stringWithFormat:@"%3.5f", newLocation.coordinate.longitude];
    NSNumber* hAcc = [NSNumber numberWithDouble:newLocation.horizontalAccuracy];
    NSNumber* vAcc = [NSNumber numberWithDouble:newLocation.verticalAccuracy];
    NSNumber* altitude = [NSNumber numberWithDouble:newLocation.altitude];
    NSString* details = [NSString stringWithFormat:@"lat: %@\nlon: %@\nacc h:%@ v:%@\nalt: %@", latitude, longitude, hAcc, vAcc, altitude];
    NSLog(@"%@", details);
    
    self.lastLocation = newLocation;
  }
}

- (void) locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error {
  NSLog(@"Location Error: %@", [error localizedDescription]);
}

@end
