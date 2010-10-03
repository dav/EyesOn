//
//  EyesOnAppDelegate.h
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>

@class StartUpController;

@interface EyesOnAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow* window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (void) doStartUp:(StartUpController*)startUpController;

@end
