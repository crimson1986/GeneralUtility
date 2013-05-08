

#import "Registration.h"
#import "TermsCondition.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "Login.h"
//#import "TabBarController.h"
#import "CustomTextField.h"

@interface Registration()
{
    CGFloat animatedDistance;
}

@property (strong, nonatomic) IBOutlet UILabel *lblNewUser;
@property (strong, nonatomic) IBOutlet CustomLabel *lblEmail;
@property (strong, nonatomic) IBOutlet CustomLabel *lblPassword;
@property (strong, nonatomic) BSKeyboardControls *keyBoardControl;
@property (strong, nonatomic) IBOutlet CustomTextField *txtPassword;
@property (strong, nonatomic) IBOutlet CustomTextField *txtEmail;
@property (strong, nonatomic) IBOutlet CustomTextField *txtFirstName;
@property (strong, nonatomic) IBOutlet UIButton *btnRegister;
@property (strong, nonatomic) IBOutlet UIButton *btnAccept;
@property (strong, nonatomic) IBOutlet OHAttributedLabel *lblAgree;
@property (strong, nonatomic) IBOutlet UIView *viewRegisterTextfield;
@property (strong, nonatomic) IBOutlet UIView *loginView;
- (void)setupLayout;

@end


@implementation Registration
@synthesize txtPassword;
@synthesize txtEmail;
@synthesize btnRegister;
@synthesize btnAccept;
@synthesize keyBoardControl;
@synthesize txtFirstName ;
@synthesize loginView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupLayout];
    self.keyBoardControl = [AppUtility setupKeyboardControls:[NSArray arrayWithObjects:self.txtFirstName,self.txtEmail,self.txtPassword, nil] forDelegate:self];
}

- (void)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setTxtPassword:nil];
    [self setTxtEmail:nil];
    [self setTxtFirstName:nil];
    [self setBtnRegister:nil];
    [self setBtnAccept:nil];
    [self setLblAgree:nil];
    [self setViewRegisterTextfield:nil];
    [self setLblEmail:nil];
    [self setLblPassword:nil];
    [self setLoginView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Custom Methods

- (void)makeAgreeText {
    self.lblAgree.numberOfLines = 0;
    //    self.lblAgree.linkColor = [UIColor colorWithRed:9.0/255.0 green:173.0/255.0 blue:200.0/255.0 alpha:1.0];
    self.lblAgree.lineBreakMode = NSLineBreakByWordWrapping;
    NSString *terms = localizedString(@"kTermsOfUse");
    NSString *pp = localizedString(@"kPrivacyPlcy");
    NSString *str = [NSString stringWithFormat:@"%@ %@ \t%@ %@",localizedString(@"kAgreeText"),pp,localizedString(@"kAnd"),terms];
    self.lblAgree.text = str;
    
    NSRange linkRange_tm = [self.lblAgree.text rangeOfString:terms];
    NSRange linkRange_pp = [self.lblAgree.text rangeOfString:pp];
    
    NSMutableAttributedString* mas = [self.lblAgree.attributedText mutableCopy];
    // Modify the the font of "FoodReporter" to bold
    if (![RMValidtor isEmptyText:terms])
    {
        //[mas setTextBold:YES range:linkRange_tm];
        [mas setTextColor:[UIColor customOrangeColor] range:linkRange_tm];
    }
    if (![RMValidtor isEmptyText:pp])
    {
        //[mas setTextBold:YES range:linkRange_pp];
        [mas setTextColor:[UIColor customOrangeColor] range:linkRange_pp];
    }
    
    self.lblAgree.attributedText = mas;
    
    self.lblAgree.underlineLinks = NO;
    [self.lblAgree setLinkColor:[UIColor customOrangeColor]];
    [self.lblAgree addCustomLink:[NSURL URLWithString:@"terms://tom1362"] inRange:linkRange_tm];
    [self.lblAgree addCustomLink:[NSURL URLWithString:@"privacy://tom1362"] inRange:linkRange_pp];
    
    self.lblAgree.centerVertically = YES;
    
    
}

- (void)setupLayout {
    self.lblEmail.text = localizedString(@"kEmailTitle");
    self.lblPassword.text = localizedString(@"kPassTitle");
    [self makeAgreeText];
}

- (IBAction)checkUnCheckPressed:(id)sender {
    btnAccept.selected = !btnAccept.isSelected;
}


- (IBAction)doRegister:(id)sender {
    if (![RMValidtor isEmptyTexts:[NSArray arrayWithObjects:self.txtPassword, self.txtEmail,self.txtFirstName, nil]])
    {
        if (btnAccept.isSelected) {
            if ([RMValidtor validateEmailWithString:self.txtEmail.text]) {
                DLog(@"do register");
            }
            else {
                DLog(@"Enter valid mail address");
                [[BCAppShared sharedInstance] showHintWithText:[[BSMessages sharedInstance] kWarning_EnterVldMail] inWindow:self.view.window];
            }
        }
        else{
            [[BCAppShared sharedInstance] showHintWithText:[[BSMessages sharedInstance] kAgree] inWindow:self.view.window];
        }
    }
    else
    {
        [[BCAppShared sharedInstance] showHintWithText:[[BSMessages sharedInstance] kPlzFillData] inWindow:self.view.window];
        [AppUtility doWringleAnimationOn:_viewRegisterTextfield];
    }
}


-(void)removeAllKeyboard
{
    [self.keyBoardControl.activeTextField resignFirstResponder];
}

#pragma mark Key board delegate
- (void)keyboardControlsDonePressed:(BSKeyboardControls *)controls
{
    [controls.activeTextField resignFirstResponder];
    [AppUtility resetViewToZeroYCordinate:self.loginView];

}

/* Either "Previous" or "Next" was pressed
 * Here we usually want to scroll the view to the active text field
 * If we want to know which of the two was pressed, we can use the "direction" which will have one of the following values:
 * KeyboardControlsDirectionPrevious        "Previous" was pressed
 * KeyboardControlsDirectionNext            "Next" was pressed
 */
- (void)keyboardControlsPreviousNextPressed:(BSKeyboardControls *)controls withDirection:(KeyboardControlsDirection)direction andActiveTextField:(id)textField
{
    [textField becomeFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.keyBoardControl.textFields containsObject:textField])
        self.keyBoardControl.activeTextField = textField;
    [AppUtility moveTextFiled:textField inView:self.loginView distance:&animatedDistance];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //    [AppUtility resetScrollingOffset:self.scrollRegister distance:animatedDistance];
   [AppUtility resetView:self.loginView distance:animatedDistance];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark
#pragma mark OHAttributedLabel

- (void)presentTermsPrivacyControllerWithUrl:(NSString *)string {
    TermsCondition *tm = [TermsCondition instanceOfNibNamed:@"TermsCondition"];
    tm.url = string;
    tm.checkBox = self.btnAccept;
    [self.navigationController presentModalViewController:tm animated:YES];
}

-(BOOL)attributedLabel:(OHAttributedLabel *)attributedLabel shouldFollowLink:(NSTextCheckingResult *)linkInfo
{
    if ([[linkInfo.URL scheme] isEqualToString:@"terms"])
    {
        // Prevent the URL from opening as we handled here manually instead
        DLog(@"terms clicked");
        [self presentTermsPrivacyControllerWithUrl:kTermsAndCondition];
		return NO;
	}
    if ([[linkInfo.URL scheme] isEqualToString:@"privacy"])
    {
        // Prevent the URL from opening as we handled here manually instead
        DLog(@"privacy clicked");
        [self presentTermsPrivacyControllerWithUrl:kPrivacyPolicy];
		return NO;
	}
    return YES;
    
}

- (IBAction)btnBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
