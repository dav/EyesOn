//
//  TargetsViewController.m
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Lumos Labs, Inc. All rights reserved.
//

#import "TargetsViewController.h"

#import "Target.h"
#import "TargetDetailViewController.h"

@interface TargetsViewController (PrivateMethods)
- (NSArray*) targets;
@end

@implementation TargetsViewController


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  UITabBarItem* tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Targets" image:[UIImage imageNamed:@"13-target.png"] tag:0];
  self.tabBarItem = tabBarItem;
  [tabBarItem release];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -

- (NSArray*) targets {
  if (_targets == nil) {
    Target* sutroTower = [Target new];
    sutroTower.name = @"Sutro Tower";
    sutroTower.latitude = [NSNumber numberWithFloat:37.755278];
    sutroTower.longitude = [NSNumber numberWithFloat:122.45277];
    
    Target* eiffelTower = [Target new];
    eiffelTower.name = @"Eiffel Tower";
    eiffelTower.latitude = [NSNumber numberWithFloat:48.8577];
    eiffelTower.longitude = [NSNumber numberWithFloat:002.295];
    
    _targets = [[NSArray alloc] initWithObjects:sutroTower, eiffelTower, nil];
    [_targets retain];
  }
  
  return _targets;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self targets] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Target Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
    
  Target* target = [[self targets] objectAtIndex:indexPath.row];
  cell.textLabel.text = target.name;
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  Target* target = [[self targets] objectAtIndex:indexPath.row];
  NSLog(@"Selected: %@", target);
	TargetDetailViewController *detailViewController = [[TargetDetailViewController alloc] initWithNibName:@"TargetDetailViewController" bundle:nil];
  detailViewController.target = target;
  [self.navigationController pushViewController:detailViewController animated:YES];
  [detailViewController release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
    
  // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
  [_targets release];
  [super dealloc];
}


@end

