//
//  EOTabBarController.m
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Lumos Labs, Inc. All rights reserved.
//

#import "EOTabBarController.h"
#import "TargetsViewController.h"

@implementation EOTabBarController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.customizableViewControllers = nil;
  
  NSMutableArray* tabs = [[NSMutableArray alloc] init];
  UINavigationController* navigationController;
  
  targetsController = [[TargetsViewController alloc] initWithNibName:@"TargetsViewController" bundle:[NSBundle mainBundle]];
  navigationController = [[UINavigationController alloc] initWithRootViewController:targetsController];
  [tabs addObject:navigationController];
  
  UITableViewController* controller = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
  UITabBarItem* tabBarItem = [[UITabBarItem alloc] initWithTitle:@"My Shots" image:[UIImage imageNamed:@"44-shoebox.png"] tag:0];
  controller.tabBarItem = tabBarItem;
  [tabBarItem release];
  [tabs addObject:controller];

  [self setViewControllers:tabs];
}

@end
