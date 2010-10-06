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
  if ((self=[super init])) {
    self.name = nil;
    self.latitude = nil;
    self.longitude = nil;
    self.photos = [[NSMutableArray alloc] init];
  }
  return self;
}

- (id)initWithName:(NSString*)name latitude:(NSNumber*)lat longitude:(NSNumber*)lon {
  if ((self=[super init])) {
    self.name = name;
    self.latitude = lat;
    self.longitude = lon;
    self.photos = [[NSMutableArray alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSFileManager *localFileManager=[[NSFileManager alloc] init];
    NSDirectoryEnumerator *dirEnum = [localFileManager enumeratorAtPath:documentsDirectory];
    
    NSString *file;
    Photo* photo = nil;
    while ((file = [dirEnum nextObject])) {
      if ([file hasPrefix:self.name]) {
        NSRange range = [file rangeOfString:@"-thumb"];
        if (range.location == NSNotFound) {
          NSString* url = [NSString stringWithFormat:@"documents://%@", file];
          [photo release];
          photo = [[Photo alloc] initWithURL:url smallURL:nil size:CGSizeMake(320, 480)];
        } else {
          NSString* smallURL = [NSString stringWithFormat:@"documents://%@", file];
          photo.smallURL = smallURL;
          NSLog(@"Target: %@; Adding Local Photo: %@", name, photo);
          [((NSMutableArray*)self.photos) addObject:photo];
        }
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
