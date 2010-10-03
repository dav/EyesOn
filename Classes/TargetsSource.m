//
//  Target.m
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Lumos Labs, Inc. All rights reserved.
//

#import "TargetsSource.h"
#import "TargetsModel.h"
#import "Target.h"

@implementation TargetsSource

- (id)init {
  if (self = [super init]) {
    _targetsModel = [TargetsModel sharedInstance];
  }
  
  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_targetsModel);
  [super dealloc];
}

- (id<TTModel>)model {
  return _targetsModel;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
  NSMutableArray* items = [[NSMutableArray alloc] init];
  
  for (Target* target in _targetsModel.targets) {
    NSString* subtitle = [NSString stringWithFormat:@"Stuff re: %@", target.name];
    NSString* url = [target URLValueWithName:@"view"];
    [items addObject:[TTTableSubtitleItem itemWithText:target.name subtitle:subtitle imageURL:nil URL:url]];
  }
  
  self.items = items; // From TTListDataSource
  TT_RELEASE_SAFELY(items);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
  if (reloading) {
    return NSLocalizedString(@"Updating targets...", @"Target updating text");
  } else {
    return NSLocalizedString(@"Loading targets...", @"Target loading text");
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
  return NSLocalizedString(@"No targets found.", @"Target load no results");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
  return NSLocalizedString(@"Sorry, there was an error loading the target data.", @"Target load error");
}

@end

