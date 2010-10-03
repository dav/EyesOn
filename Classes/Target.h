//
//  Target.h
//  TTFacebook
//
//  Created by dav on 10/2/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Photo;

@interface Target : NSObject {
  NSString* _name;
  NSNumber* _latitiude;
  NSNumber* _longitiude;
  NSMutableArray* _photos;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSNumber* latitude;
@property (nonatomic, retain) NSNumber* longitude;
@property (nonatomic, retain) NSArray* photos;
@property (nonatomic, readonly) NSString* slug;

- (id)initWithName:(NSString*)name latitude:(NSNumber*)lat longitude:(NSNumber*)lon;
- (void) addPhoto:(Photo*)photo;

@end
