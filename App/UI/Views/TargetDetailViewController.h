//
//  TargetDetailViewController.h
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Lumos Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Target;

@interface TargetDetailViewController : UIViewController {
  IBOutlet UIButton* cameraButton;
  Target* _target;
}

@property (nonatomic, retain) Target* target;

- (IBAction) cameraButtonTapped:(id)sender;

@end
