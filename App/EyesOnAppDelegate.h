//
//  EyesOnAppDelegate.h
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EyesOnAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
  UIWindow *window;
  UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
