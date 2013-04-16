//
//  RMForgotPassword.m
//  RegistrationModule
//
//  Created by iPhone Developer on 03/12/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import "ForgotPassword.h"
#import "Login.h"
#import "CustomTextField.h"

@interface ForgotPassword () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblMessage;
@property (strong, nonatomic) IBOutlet UIView *forgotView;
@property (strong, nonatomic) IBOutlet CustomTextField *txtMailAddress;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
@property (strong, nonatomic) IBOutlet CustomLabel *lblEmail;
@property (strong, nonatomic) BSKeyboardControls *keyBoardControl;
- (void)loadLayout;
@end

@implementation ForgotPassword
@synthesize lblMessage;
@synthesize txtMailAddress;
@synthesize btnSend;

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
    [self loadLayout];
    self.keyBoardControl = [AppUtility setupKeyboardControls:[NSArray arrayWithObjects:self.txtMailAddress, nil] forDelegate:self];
}

- (void)viewDidUnload
{
    [self setLblMessage:nil];
    [self setTxtMailAddress:nil];
    [self setBtnSend:nil];
    [self setLblEmail:nil];
 
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

- (void)loadLayout {
    
    self.lblEmail.text = localizedString(@"kEmailAddress");
    self.txtMailAddress.delegate = self;
}


- (void)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)resetClicked:(id)sender {
    
    [self.txtMailAddress resignFirstResponder];
    if (![RMValidtor isEmptyTexts:[NSArray arrayWithObjects:self.txtMailAddress,nil]]){
        if ([RMValidtor validateEmailWithString:self.txtMailAddress.text]) {
            DLog(@"continue");
           
        }
        else {
            [[BCAppShared sharedInstance] showHintWithText:[[BSMessages sharedInstance] kWarning_EnterVldMail] inWindow:self.view.window];
        }
    }
    else
    {
        [[BCAppShared sharedInstance] showHintWithText:[[BSMessages sharedInstance] kEnterEmail] inWindow:self.view.window];
        [AppUtility doWringleAnimationOn:self.forgotView];
    }
    
}
- (void)gotoChangePassword {
//    BTChangeController *changePass = [BTChangeController instanceOfNibNamed:@"BTChangeController"];
//    [self.navigationController pushViewController:changePass animated:YES];
}

#pragma mark Key board delegate
- (void)keyboardControlsDonePressed:(BSKeyboardControls *)controls
{
    [controls.activeTextField resignFirstResponder];
}
#pragma mark Textfield Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.keyBoardControl.textFields containsObject:textField])
        self.keyBoardControl.activeTextField = textField;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
//    [self resetClicked];
    return YES;
}

@end
