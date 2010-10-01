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
  IBOutlet UIImageView* mainImageView;
  IBOutlet UILabel* mainLabel;
  
  Target* _target;
  OverlayViewController* _overlayViewController;
  CLLocationManager* _locationManager;
  CLLocation* _lastLocation;
}

@property (nonatomic, retain) Target* target;
@property (nonatomic, retain) OverlayViewController* overlayViewController;
@property (nonatomic, retain) CLLocation* lastLocation;

- (IBAction) cameraButtonTapped:(id)sender;

@end
