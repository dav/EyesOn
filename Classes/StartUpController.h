#import <UIKit/UIKit.h>

@interface StartUpController : UIViewController {
  IBOutlet UILabel* label;
  IBOutlet UILabel* versionLabel;
  IBOutlet UIActivityIndicatorView* activityIndicator;
}

@property (nonatomic, retain) UILabel* label;

- (void) setText:(NSString*)text;
- (void) setTextAndStopAnimating:(NSString*)text;

@end
