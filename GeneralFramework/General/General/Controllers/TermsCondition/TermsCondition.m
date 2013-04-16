//
//  RMTermsCondition.m
//  RegistrationModule
//
//  Created by iPhone Developer on 03/12/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import "TermsCondition.h"
NSString *kTermsAndCondition = @"http://projects.spinxweb.net/beachory/mpage.aspx?page=mobile-terms-of-service";
NSString *kPrivacyPolicy = @"http://projects.spinxweb.net/beachory/mpage.aspx?page=mobile-privacy-policy";

@interface TermsCondition () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *wbLoadContent;
@property (strong, nonatomic) IBOutlet UIButton *btnAccept;
@property (strong, nonatomic) IBOutlet UIButton *btnReject;
- (void)setupLayout;
@end

@implementation TermsCondition
@synthesize wbLoadContent;
@synthesize btnAccept;
@synthesize btnReject;
@synthesize url;
@synthesize checkBox;

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
}

- (void)viewDidUnload
{
    [self setWbLoadContent:nil];
    [self setBtnAccept:nil];
    [self setBtnReject:nil];
    [self setContentView:nil];
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

- (void)setupLayout {
    
    
    [self.wbLoadContent loadRequest:[NSURLRequest requestWithURL:[NSURL EncodedURLWithString:self.url]]];
    self.wbLoadContent.delegate = self;
    if (!self.checkBox) {
        btnAccept.hidden = YES;
        btnReject.hidden = YES;
    }
    [btnAccept setTitle:localizedString(@"kAccept") forState:UIControlStateNormal];
    [btnReject setTitle:localizedString(@"kReject") forState:UIControlStateNormal];
    [btnAccept addTarget:self action:@selector(accept:) forControlEvents:UIControlEventTouchUpInside];
    [btnReject addTarget:self action:@selector(reject:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)accept:(id)sender {
    self.checkBox.selected = YES;
    [[BCAppShared sharedInstance] hideIndicator];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)reject:(id)sender {
    self.checkBox.selected = NO;
    [[BCAppShared sharedInstance] hideIndicator];
    [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
}


#pragma mark Webview Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[BCAppShared sharedInstance] showIndicatorWithText:localizedString(@"kPWait") inWindow:self.view.window];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[BCAppShared sharedInstance] hideIndicator];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[BCAppShared sharedInstance] hideIndicator];
}

#pragma mark Header Delegate
- (void)backButtonClicked:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
- (void)filterButtonClicked:(id)sender{}
- (void)getDirections{}
- (void)showMapClicked:(id)sender{}
- (void)displayList:(id)sender{}

@end
