//
//  RMLogin.m
//  RegistrationModule
//
//  Created by Brijesh 04 on 27/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Login.h"
#import "Registration.h"
#import "ForgotPassword.h"
#import "FirstResetPassword.h"
#import "CustomTextField.h"

@interface Login () <FirstResetPasswordDelegate>
{
    CGFloat animatedDistance;
    
}

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet CustomTextField *txtEmail;
@property (strong, nonatomic) IBOutlet CustomTextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnRegister;
@property (strong, nonatomic) IBOutlet UIButton *btnFPass;
@property (strong, nonatomic) BSKeyboardControls *keyBoardControl;
@property (strong, nonatomic) IBOutlet CustomLabel *lblEmail;
@property (strong, nonatomic) IBOutlet CustomLabel *lblPassword;

@end

@implementation Login

@synthesize loginView;
@synthesize txtEmail;
@synthesize txtPassword;
@synthesize btnLogin;
@synthesize btnRegister;
@synthesize btnFPass;
@synthesize keyBoardControl;
@synthesize tabbarselected;

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

- (void)layoutInitialization {

    self.lblEmail.text = localizedString(@"kEmailTitle");
    self.lblPassword.text = localizedString(@"kPassTitle");
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self layoutInitialization];
    self.keyBoardControl = [AppUtility setupKeyboardControls:[NSArray arrayWithObjects:self.txtEmail,self.txtPassword, nil] forDelegate:self];
    self.topNavigationBar.btnBack.hidden = YES;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    CFRelease(NULL);
//    ((UIImageView *)self.view).image = nil;
}


- (IBAction)forgotBtnClick:(id)sender
{
    [self forgotPassword];
}

- (void)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kSearchScreenNotification object:nil];
}

- (void)viewDidUnload
{
    [self setLoginView:nil];
    [self setTxtEmail:nil];
    [self setTxtPassword:nil];
    [self setBtnLogin:nil];
    [self setBtnRegister:nil];
    [self setBtnFPass:nil];
    [self setKeyBoardControl:nil];
    [self setLblEmail:nil];
    [self setLblPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark Custom methods

- (IBAction)gotoRegister:(id)sender {
    [self removeAllKeyboard];
    Registration *rg = [Registration instanceOfNibNamed:@"Registration"];
    rg.topNavigationBar.btnBack.hidden = NO;
    [self.navigationController pushViewController:rg animated:YES];
}

- (IBAction)doLogin:(id)sender {

    [self removeAllKeyboard];
    if (![RMValidtor isEmptyTexts:[NSArray arrayWithObjects:self.txtEmail,self.txtPassword, nil]]) 
    {
        if ([RMValidtor validateEmailWithString:self.txtEmail.text])
        {
            [[BCAppShared sharedInstance] showIndicatorWithText:localizedString(@"kPWait") inWindow:self.view.window];
            DLog(@"do login");
            NSString *loginStr = [NSString stringWithFormat:@"login/%@/%@",self.txtEmail.text,self.txtPassword.text];
            DLog(@"loginStr %@",loginStr);
            [[NSNotificationCenter defaultCenter] postNotificationName:kTabbarNotification object:nil];
        }
        else{
            DLog(@"Enter valid mail address");
            [[BCAppShared sharedInstance] showHintWithText:[[BSMessages sharedInstance] kWarning_EnterVldMail] inWindow:self.view.window];
        }
        
    }
    else 
    {
        [[BCAppShared sharedInstance] showHintWithText:[[BSMessages sharedInstance] kPlzFillData] inWindow:self.view.window];
        [AppUtility doWringleAnimationOn:self.loginView];
    }
    
}

- (void)SaveClicked {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)forgotPassword {
    [self removeAllKeyboard];
    ForgotPassword *fp = [ForgotPassword instanceOfNibNamed:@"ForgotPassword"];
    fp.topNavigationBar.btnBack.hidden = NO;
    [self.navigationController pushViewController:fp animated:YES];
}


#pragma mark Key board delegate
- (void)keyboardControlsDonePressed:(BSKeyboardControls *)controls
{
    [controls.activeTextField resignFirstResponder];
   // [AppUtility resetViewToZeroYCordinate:self.view];
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
    
    //[AppUtility moveTextFiled:textField inView:self.mainView distance:&animatedDistance];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //[AppUtility resetView:self.mainView distance:animatedDistance];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)removeAllKeyboard
{
    [self.keyBoardControl.activeTextField resignFirstResponder];
}



@end
