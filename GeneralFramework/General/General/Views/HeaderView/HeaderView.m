
#import "HeaderView.h"

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setBackButtonHide:(BOOL)hide {
    self.btnBack.hidden = hide;
}

- (void)setBackBookButtonHide:(BOOL)hide bookText:(NSString *)bookText {
    self.lblBookbackTitle.hidden = hide;
    self.lblBookbackTitle.text = bookText;
}

- (IBAction)showLeftMenu:(id)sender {
//    [[AppDelegate sharedInstance].menuController showLeftController:YES];
}

-(void)showSettingAndRemoveButton
{
//    [self.btnCall setHidden:NO];
}
- (void)setTitle:(NSString *)text {
    self.lblHeadingTitle.text = text;
    CGRect rect = self.lblHeadingTitle.frame;
    rect.size.height = CGRectGetHeight(self.viewNavigation.frame);
    self.lblHeadingTitle.frame = rect;
}

@end
