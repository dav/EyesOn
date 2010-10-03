//
//  StartUpController.m
//  BrainTrainer
//
//  Created by dav on 12/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "StartUpController.h"
#import "EyesOnAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation StartUpController

@synthesize label;

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
  [activityIndicator startAnimating];
  NSString* version = [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
  versionLabel.text = [NSString stringWithFormat:@"Version %@", version];
  
}

- (void)viewDidAppear:(BOOL)animated {
  [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
}

- (void) run {
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  [(AppDelegate) doStartUp:self];
  [pool release];
} 

- (void) setText:(NSString*)text {
  label.text = text;
}

- (void) setTextAndStopAnimating:(NSString*)text {
  [self setText:text];
  [activityIndicator stopAnimating];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
  [label release];
  [activityIndicator release];
  [super dealloc];
}

@end
