//
//  FirstResetPassword.m
//  Beachory
//
//  Created by Brijesh 01 on 1/25/13.
//  Copyright (c) 2013 mycompany. All rights reserved.
//

#import "FirstResetPassword.h"
#import "Login.h"
#import "CustomTextField.h"

@interface FirstResetPassword (){
    CGFloat animatedDistance;
}
@property (strong, nonatomic) BSKeyboardControls *keyBoardControl;
@property (strong, nonatomic) IBOutlet CustomTextField *txtNewPassowrd;
@property (strong, nonatomic) IBOutlet CustomTextField *txtConfirmPassword;
@property (strong, nonatomic) IBOutlet UIView *textFeildContainer;
@end

@implementation FirstResetPassword
@synthesize keyBoardControl;
@synthesize txtNewPassowrd;
@synthesize txtConfirmPassword;
@synthesize delegateresPass;
@synthesize textFeildContainer;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.keyBoardControl = [AppUtility setupKeyboardControls:[NSArray arrayWithObjects:self.txtNewPassowrd,self.txtConfirmPassword, nil] forDelegate:self];
    // Do any additional setup after loading the view from its nib.
}
- (void)startBounce {
    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3/1.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [UIView commitAnimations];
}
- (void)bounce1AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    [UIView commitAnimations];
}

- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3/2];
    self.view.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}
-(IBAction)btnSave:(id)sender{
    if (![RMValidtor isEmptyTexts:[NSArray arrayWithObjects:self.txtNewPassowrd,self.txtConfirmPassword, nil]])
    {
        if ([self.txtNewPassowrd.text isEqualToString:self.txtConfirmPassword.text]) {
            
            
        }else{
            [[BCAppShared sharedInstance] showHintWithText:[[BSMessages sharedInstance] kErrorPass] inWindow:self.view.window];
        }
    }
    else
    {
        [[BCAppShared sharedInstance] showHintWithText:[[BSMessages sharedInstance] kPlzFillData] inWindow:self.view.window];
        [AppUtility doWringleAnimationOn:self.textFeildContainer];
    }

    
}

#pragma mark Key board delegate
- (void)keyboardControlsDonePressed:(BSKeyboardControls *)controls
{
    [controls.activeTextField resignFirstResponder];
    [AppUtility resetViewToZeroYCordinate:self.view];
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
    
    [AppUtility moveTextFiled:textField inView:self.view distance:&animatedDistance];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [AppUtility resetView:self.view distance:animatedDistance];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
