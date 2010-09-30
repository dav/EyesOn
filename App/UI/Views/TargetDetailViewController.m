//
//  TargetDetailViewController.m
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Lumos Labs, Inc. All rights reserved.
//

#import "TargetDetailViewController.h"
#import "Target.h"

@implementation TargetDetailViewController

@synthesize target = _target;

- (void)viewDidLoad {
  [super viewDidLoad];
  if (self.target) self.title = self.target.name;
  [cameraButton setTitle:@"Take a photo" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -

- (IBAction) cameraButtonTapped:(id)sender {
}

@end
