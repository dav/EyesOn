//
//  Target.h
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Lumos Labs, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TargetsModel;

@interface TargetsSource : TTListDataSource {
  TargetsModel* _targetsModel;  
}

@end
