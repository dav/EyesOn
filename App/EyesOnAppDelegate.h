//
//  EyesOnAppDelegate.h
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EOTabBarController;

@interface EyesOnAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
  UIWindow* window;
  EOTabBarController* tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, retain) IBOutlet EOTabBarController* tabBarController;

@end
