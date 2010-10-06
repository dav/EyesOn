//
//  TargetsModel.h
//  EyesOn
//
//  Created by dav on 10/2/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import <Three20/Three20.h>

@class Target;

@interface TargetsModel : TTModel {
  NSArray* _targets;
}

@property (nonatomic, retain) NSArray* targets;

+ (TargetsModel*) sharedInstance;

- (Target*)targetForSlug:(NSString*)slug;

@end
