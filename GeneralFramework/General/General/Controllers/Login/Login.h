

#import <UIKit/UIKit.h>



@interface Login : CustomViewController{
    NSString *tabbarselected;
}
@property (strong, nonatomic) NSString *tabbarselected;


- (void)removeAllKeyboard;
- (IBAction)forgotBtnClick:(id)sender;
@end
