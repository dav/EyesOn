//
//  TargetDetailViewController.m
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Lumos Labs, Inc. All rights reserved.
//

#import "TargetDetailViewController.h"
#import "Target.h"
#import "TargetsModel.h"
#import "OverlayViewController.h"
#import "EOLocationProvider.h"
#import "Photo.h"

@interface  TargetDetailViewController () 
- (IBAction) cameraButtonTapped:(id)sender;
- (void) savePicture:(UIImage*)picture withLocation:(CLLocation*)location;
@end

@implementation TargetDetailViewController

@synthesize target = _target;
@synthesize overlayViewController = _overlayViewController;

- (id) initWithSlug:(NSString*)slug {
  if ((self=[super init])) {
    Target* target = [[TargetsModel sharedInstance] targetForSlug:slug];
    self.target = target;
    self.title = self.target.name;
    self.tableViewStyle = UITableViewStyleGrouped;
  }
  return self;
}

#pragma mark TTModelViewController

- (void) createModel {
  NSArray* sectionArray = [[NSArray alloc] initWithObjects:@"Photos", nil];
  NSMutableArray* photosSectionArray = [[NSMutableArray alloc] init];
  
  [photosSectionArray addObject:[TTTableButton itemWithText:@"Take new photo" delegate:self selector:@selector(cameraButtonTapped:)]];
  if ([self.target.photos count]>0) {
    Photo* photo = [self.target.photos lastObject];
    
    NSString* labelText = [NSString stringWithFormat:@"%d Photos", [self.target.photos count]];
    NSString* imageURL = [photo URLForVersion:TTPhotoVersionThumbnail];
    NSString* viewURL = [self.target URLValueWithName:@"photosView"];
    NSLog(@"Most Recent Image URL: %@", imageURL);
    TTTableImageItem* imageItem = [TTTableImageItem itemWithText:labelText imageURL:imageURL URL:viewURL];
    [photosSectionArray addObject:imageItem];
  }
    
  NSArray* itemsArray = [[NSArray alloc] initWithObjects:photosSectionArray, nil];
  
  self.dataSource = [TTSectionedDataSource dataSourceWithItems:itemsArray sections:sectionArray];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.overlayViewController = [[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:nil];
  self.overlayViewController.delegate = self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
  self.overlayViewController = nil;
  [super viewDidUnload];
}


- (void)dealloc {
  [_overlayViewController release];
  [super dealloc];
}

#pragma mark -

- (IBAction) cameraButtonTapped:(id)sender {
  NSLog(@"tapped");
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [self.overlayViewController setupImagePicker];
    [self presentModalViewController:self.overlayViewController.imagePickerController animated:YES];
  }
}

#pragma mark -
#pragma mark OverlayViewControllerDelegate

- (NSString*) savedNameForImage:(UIImage*)image named:(NSString*)name {
  NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString* filename = [NSString stringWithFormat:@"%@.jpg", name];
  NSString* path = [NSString stringWithFormat:@"%@/%@", documentsDirectory, filename];
  NSLog(@"file path: %@", path);
  if([imageData writeToFile:path atomically:YES]) {
    return filename;
  }
  return nil;
}

- (NSString*) savedNameForMetadata:(CLLocation*)location named:(NSString*)name {
  NSDictionary* metadataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSNumber numberWithDouble:location.coordinate.latitude], @"latitude",
                                [NSNumber numberWithDouble:location.coordinate.longitude], @"longitude", nil];
  SBJSON* jsonWriter = [SBJSON new];
  NSError* error = nil;
  NSString* json = [jsonWriter stringWithObject:metadataDict error:&error];
  [jsonWriter release];
  if (error) {
    NSLog(@"JSON Error: %@", [error localizedDescription]);
  } else {
    NSLog(@"JSON: %@", json);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* filename = [NSString stringWithFormat:@"%@.json", name];
    NSString* path = [NSString stringWithFormat:@"%@/%@", documentsDirectory, filename];
    NSLog(@"file path: %@", path);
    if([json writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
      return filename;
    } else {
      NSLog(@"File Error: %@", [error localizedDescription]);
    }
  }
  
  return nil;
}

- (void) didTakePicture:(UIImage*)picture {
  CLLocation* location = [EOLocationProvider sharedInstance].lastLocation;
  NSLog(@"picture: %dx%d %@", (int)picture.size.width, (int)picture.size.height, picture);
  NSLog(@"Picture location = %@", location);
  
  [self savePicture:picture withLocation:location];
  [self didFinishWithCamera];
}

- (void)didFinishWithCamera {
  [self dismissModalViewControllerAnimated:YES];
}

- (void) savePicture:(UIImage*)picture withLocation:(CLLocation*)location {
  BOOL needsRotation = (picture.size.width > picture.size.height);
  UIImage* fullImage = [picture transformWidth:320 height:480 rotate:!needsRotation];
  NSString* basename = [NSString stringWithFormat:@"%@-%@", self.target.name, [NSDate date]];
  NSString* filename = [self savedNameForImage:fullImage named:basename];
  if (filename) {
    // Create thumbnail
    UIImage* thumbnailImage = [picture transformWidth:50 height:50 rotate:needsRotation];
    NSString* thumbnailName = [NSString stringWithFormat:@"%@-thumb", basename];
    NSString* thumbnailFilename = [self savedNameForImage:thumbnailImage named:thumbnailName];
    if (thumbnailFilename) {
      NSString* fileURL = [NSString stringWithFormat:@"documents://%@", filename];
      NSString* thumbnailURL = [NSString stringWithFormat:@"documents://%@", thumbnailFilename];
      Photo* photo = [[Photo alloc] initWithURL:fileURL smallURL:thumbnailURL size:fullImage.size];
      NSLog(@"Photo: %@", photo);
      [self.target addPhoto:photo];
    }
    
    //Create location metadata
    NSString* metadataFilename = [self savedNameForMetadata:location named:basename];
    NSLog(@"Metadata: %@", metadataFilename);
    
    // Store key to defaults
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* basenames = [defaults objectForKey:@"LocalPhotoSet"];
    if (basenames == nil) {
      basenames = [NSMutableArray arrayWithCapacity:1];
    }
    [basenames addObject:basename];
    [defaults setObject:basenames forKey:@"LocalPhotoSet"];
  }
}
@end
