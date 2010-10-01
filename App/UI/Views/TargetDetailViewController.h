//
//  TargetDetailViewController.h
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Lumos Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayViewController.h"
#import <CoreLocation/CoreLocation.h>

@class Target;

@interface TargetDetailViewController : UIViewController <CLLocationManagerDelegate, OverlayViewControllerDelegate> {
  IBOutlet UIButton* cameraButton;
  
  Target* _target;
  OverlayViewController* _overlayViewController;
  CLLocationManager* _locationManager;
}

@property (nonatomic, retain) Target* target;
@property (nonatomic, retain) OverlayViewController* overlayViewController;

- (IBAction) cameraButtonTapped:(id)sender;

@end
