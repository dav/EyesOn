//
//  TargetDetailViewController.h
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Lumos Labs, Inc. All rights reserved.
//

#import <Three20/Three20.h>
#import "OverlayViewController.h"

@class Target;

@interface TargetDetailViewController : TTTableViewController <OverlayViewControllerDelegate> {
  Target* _target;
  OverlayViewController* _overlayViewController;
}

@property (nonatomic, retain) Target* target;
@property (nonatomic, retain) OverlayViewController* overlayViewController;

- (id) initWithSlug:(NSString*)slug;

@end
