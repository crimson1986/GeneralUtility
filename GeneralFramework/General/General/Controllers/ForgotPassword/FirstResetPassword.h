
#import <UIKit/UIKit.h>
@protocol FirstResetPasswordDelegate;
@interface FirstResetPassword : CustomViewController{
    id<FirstResetPasswordDelegate> _delegateresPass;
    
  }
@property (nonatomic)id<FirstResetPasswordDelegate> delegateresPass;
-(IBAction)btnSave:(id)sender;

- (void)startBounce;
@end


@protocol FirstResetPasswordDelegate <NSObject>

- (void)SaveClicked;

@end
