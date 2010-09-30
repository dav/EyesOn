//
//  Target.h
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Lumos Labs, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Target : NSObject {
  NSString* _name;
  NSNumber* _latitiude;
  NSNumber* _longitiude;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSNumber* latitude;
@property (nonatomic, retain) NSNumber* longitude;

@end
