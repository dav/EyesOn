//
//  EyesOnAppDelegate.m
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import "EyesOnAppDelegate.h"
#import "StartUpController.h"
#import "EOLocationProvider.h"

#import "PhotoController.h"
#import "TargetsController.h"
#import "TargetDetailViewController.h"

#import "Target.h"

@interface EyesOnAppDelegate ()
- (void) loadNavigator;
@end

@implementation EyesOnAppDelegate

@synthesize window;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { 
  
  [EOLocationProvider sharedInstance]; // Init the location provider
  
  [self loadNavigator];

  /*
  window = [[UIWindow alloc] init];
	StartUpController* startUpController = [[StartUpController alloc] initWithNibName:@"StartUpController" bundle:[NSBundle mainBundle]];
	[window addSubview:startUpController.view];
  [startUpController release];
  [window makeKeyAndVisible];
   */
  return YES;
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
  [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
   */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  /*
   Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
   */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}


- (void)applicationWillTerminate:(UIApplication *)application {
  /*
   Called when the application is about to terminate.
   See also applicationDidEnterBackground:.
   */
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
 }
 */

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
 }
 */


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
  /*
   Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
   */
}


- (void)dealloc {
  [window release];
  [super dealloc];
}

- (void) loadNavigator {
  TTNavigator* navigator = [TTNavigator navigator];
  navigator.supportsShakeToReload = YES;
  navigator.persistenceMode = TTNavigatorPersistenceModeAll;
  
  TTURLMap* map = navigator.URLMap;
  [map from:@"*" toViewController:[TTWebController class]];
  [map from:@"tt://photoTest1" toViewController:[PhotoController class]];
  
  [map from:[Target class] name:@"view" toURL:@"tt://targets/view/(slug)"];
  [map from:@"tt://targets" toViewController:[TargetsController class]];
  [map from:@"tt://targets/view/(initWithSlug:)" toViewController:[TargetDetailViewController class]];
  
  if (![navigator restoreViewControllers]) {
    [navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://targets"]];
  }
}

#pragma mark StartUpController

- (void) doStartUp:(StartUpController*)startUpController {
//  [self performSelectorInBackground:@selector(registerWithServer) withObject:nil];
  
  
  [startUpController performSelectorOnMainThread:@selector(setText:) withObject:@"Validating database..." waitUntilDone:YES];
  
  [self performSelectorOnMainThread:@selector(mainThreadStartUpTasks:) withObject:startUpController waitUntilDone:YES];
}

- (void) mainThreadStartUpTasks:(StartUpController*)startUpController {
  NSLog(@"=== BEGIN mainThreadStartUpTasks ===");
  [startUpController.view removeFromSuperview];
  
  [NSThread sleepForTimeInterval:1.0];

  [self loadNavigator];
}

@end

