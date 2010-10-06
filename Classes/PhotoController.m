#import "PhotoController.h"
#import "PhotoSource.h"
#import "Photo.h"

#import "TargetsModel.h"
#import "Target.h"

@implementation PhotoController

- (id) initWithTargetSlug:(NSString*)slug {
  if ((self = [super init])) {
    Target* target = [[TargetsModel sharedInstance] targetForSlug:slug];
    if (target) {
      self.photoSource = [[PhotoSource alloc] initWithTitle:target.name photos:target.photos photos2:nil];
    }
  }
  return self;
}

@end
