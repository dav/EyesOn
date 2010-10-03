//
//  Photo.h
//  EyesOn
//
//  Created by dav on 10/2/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Photo : NSObject <TTPhoto> {
  id<TTPhotoSource> _photoSource;
  NSString* _thumbURL;
  NSString* _smallURL;
  NSString* _URL;
  CGSize _size;
  NSInteger _index;
  NSString* _caption;
  CLLocation* _location;
}

@property (nonatomic, retain) CLLocation* location;

- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size;
- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size caption:(NSString*)caption;
- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size location:(CLLocation*)location;

@end
