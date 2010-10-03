//
//  Target.m
//
//  Created by dav on 10/2/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import "Target.h"
#import "Photo.h"

@implementation Target

@synthesize name = _name;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize photos = _photos;

- (id) init {
  if (self=[super init]) {
    self.name = nil;
    self.latitude = nil;
    self.longitude = nil;
    self.photos = [[NSMutableArray alloc] init];
  }
  return self;
}

- (id)initWithName:(NSString*)name latitude:(NSNumber*)lat longitude:(NSNumber*)lon {
  if (self=[super init]) {
    self.name = name;
    self.latitude = lat;
    self.longitude = lon;
    self.photos = [[NSMutableArray alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSFileManager *localFileManager=[[NSFileManager alloc] init];
    NSDirectoryEnumerator *dirEnum = [localFileManager enumeratorAtPath:documentsDirectory];
    
    NSString *file;
    while (file = [dirEnum nextObject]) {
      if ([file hasPrefix:self.name]) {
        NSString* fileURL = [NSString stringWithFormat:@"file://%@/%@", documentsDirectory, file];
        Photo* photo = [[Photo alloc] initWithURL:fileURL smallURL:fileURL size:CGSizeZero];
        NSLog(@"Adding Found Photo: %@", photo);
        [((NSMutableArray*)self.photos) addObject:photo];
      }
    }
    [localFileManager release];  }
  return self;
}

- (void) dealloc {
  TT_RELEASE_SAFELY(_name);
  TT_RELEASE_SAFELY(_latitude);
  TT_RELEASE_SAFELY(_longitude);
  TT_RELEASE_SAFELY(_photos);
  [super dealloc];
}

- (NSString*) slug {
  return [self.name stringByReplacingOccurrencesOfString:@" " withString:@"_"];
}

- (void) addPhoto:(Photo*)photo {
  [_photos addObject:photo];
}

- (NSString*) description {
  return [NSString stringWithFormat:@"Target:%@ @ <%@,%@>", self.name, self.latitude, self.longitude];
}

@end
