//
//  TargetsController.m
//  EyesOn
//
//  Created by dav on 10/2/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import "TargetsController.h"
#import "TargetsSource.h"

@implementation TargetsController

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    self.title = @"Targets";
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Targets" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
//    self.tableViewStyle = UITableViewStyleGrouped;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  BOOL ui = self.view.userInteractionEnabled;
  NSLog(@"userInteractionEnabled = %d", ui);
}

#pragma mark TTModelViewController

- (void)createModel {
  self.dataSource = [[[TargetsSource alloc] init] autorelease];
}

- (id<UITableViewDelegate>)createDelegate {
  return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end
