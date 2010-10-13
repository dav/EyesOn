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
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray* basenames = [defaults objectForKey:@"LocalPhotoSet"];
    if (basenames == nil) {
      NSLog(@"No stored photos in defaults");
    } else {
      for (NSString* basename in basenames) {
        if ([basename hasPrefix:self.name]) {
          NSString* fullImageFileName = [NSString stringWithFormat:@"%@.jpg", basename];
          NSString* thumbnailImageFileName = [NSString stringWithFormat:@"%@-thumb.jpg", basename];
          NSString* metadataFileName = [NSString stringWithFormat:@"%@.json", basename];
          
          NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
          NSString *documentsDirectory = [paths objectAtIndex:0];
          NSFileManager *localFileManager=[[NSFileManager alloc] init];
          
          NSString* mainFilePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fullImageFileName];
          NSString* metadataFilePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, metadataFileName];
          if (![localFileManager fileExistsAtPath:mainFilePath]) {
            NSLog(@"Keyed file does not exist: %@", mainFilePath);
          } else {
            NSString* url = [NSString stringWithFormat:@"documents://%@", fullImageFileName];
            NSString* smallUrl = [NSString stringWithFormat:@"documents://%@", thumbnailImageFileName];
            NSString* json = [[NSString alloc] initWithContentsOfFile:metadataFilePath];
            
            CLLocation* location = nil;
            SBJSON* jsonParser = [SBJSON new];
            NSDictionary* metadata = [jsonParser objectWithString:json];
            [jsonParser release];
            if (metadata) {
              NSNumber* latNum = [metadata objectForKey:@"latitude"];
              NSNumber* lonNum = [metadata objectForKey:@"longitude"];
              if (lat && lon) {
                location = [[CLLocation alloc] initWithLatitude:[latNum doubleValue] longitude:[lonNum doubleValue]];
              }
            }
            
            Photo* photo = [[Photo alloc] initWithURL:url smallURL:smallUrl size:CGSizeMake(320, 480) caption:json location:location];
            NSLog(@"Target: %@; Adding Local Photo: %@", self.name, photo);
            [((NSMutableArray*)self.photos) addObject:photo];
            [photo release];
          }
        }
      }
    }
  }
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
