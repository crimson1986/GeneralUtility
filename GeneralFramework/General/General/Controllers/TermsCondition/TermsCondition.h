

#import <UIKit/UIKit.h>
extern NSString *kTermsAndCondition;
extern NSString *kPrivacyPolicy;
@interface TermsCondition : CustomViewController
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIButton *checkBox;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@end
