//
//  Photo.m
//  EyesOn
//
//  Created by dav on 10/2/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import "Photo.h"

@implementation Photo

@synthesize photoSource = _photoSource, size = _size, index = _index, location = _location, caption = _caption;

- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size {
  return [self initWithURL:URL smallURL:smallURL size:size location:nil];
}

- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size location:(CLLocation*)location {
  if (self = [super init]) {
    _photoSource = nil;
    _URL = [URL copy];
    _smallURL = [smallURL copy];
    _thumbURL = [smallURL copy];
    _size = size;
    _location = [location copy];
    _index = NSIntegerMax;
    _caption = nil;
  }
  return self;
}

- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size caption:(NSString*)caption {
  if (self = [super init]) {
    _photoSource = nil;
    _URL = [URL copy];
    _smallURL = [smallURL copy];
    _thumbURL = [smallURL copy];
    _size = size;
    _caption = [caption copy];
    _index = NSIntegerMax;
  }
  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_URL);
  TT_RELEASE_SAFELY(_smallURL);
  TT_RELEASE_SAFELY(_thumbURL);
  TT_RELEASE_SAFELY(_location);
  [super dealloc];
}

- (NSString*) description {
  return [NSString stringWithFormat:@"Photo:\n-URL: %@", _URL];
}

#pragma mark TTPhoto

- (NSString*)URLForVersion:(TTPhotoVersion)version {
  if (version == TTPhotoVersionLarge) {
    return _URL;
  } else if (version == TTPhotoVersionMedium) {
    return _URL;
  } else if (version == TTPhotoVersionSmall) {
    return _smallURL;
  } else if (version == TTPhotoVersionThumbnail) {
    return _thumbURL;
  } else {
    return nil;
  }
}

@end
