//
//  TargetsModel.m
//  EyesOn
//
//  Created by dav on 10/2/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import "TargetsModel.h"
#import "Target.h"

@implementation TargetsModel

#pragma mark -

static TargetsModel* sharedInstance = nil;

+ (TargetsModel*)sharedInstance {
  @synchronized(self) {
    if (sharedInstance == nil) {
			sharedInstance = [[TargetsModel alloc] init];
    }
  }  
  return sharedInstance;
}

#pragma mark -

@synthesize targets = _targets;

- (id) init {
  if ((self=[super init])) {
    Target* sutroTower = [[Target alloc] initWithName:@"Sutro Tower" latitude:[NSNumber numberWithFloat:37.755278f] longitude:[NSNumber numberWithFloat:122.45277f]];
    Target* eiffelTower = [[Target alloc] initWithName:@"Eiffel Tower" latitude:[NSNumber numberWithFloat:48.8577f] longitude:[NSNumber numberWithFloat:002.295f]];
    self.targets = [[NSArray alloc] initWithObjects:sutroTower, eiffelTower, nil];
    [sutroTower release];
    [eiffelTower release];
  }
  return self;
}

- (void) dealloc {
  TT_RELEASE_SAFELY(_targets);
  [super dealloc];
}

#pragma mark -

- (Target*)targetForSlug:(NSString*)slug {
  for (Target* target in _targets) {
    if ([slug isEqualToString:[target slug]]) return target;
  }
  return nil;
}

@end
