//
//  EOLocationProvider.h
//  EyesOn
//
//  Created by dav on 10/2/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface EOLocationProvider : NSObject <CLLocationManagerDelegate> {
  CLLocationManager* _locationManager;
  CLLocation* _lastLocation;
}

@property (nonatomic, retain) CLLocation* lastLocation;

+ (EOLocationProvider*) sharedInstance;

@end
