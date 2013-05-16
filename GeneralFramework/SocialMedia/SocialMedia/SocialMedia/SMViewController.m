//
//  SMViewController.m
//  SocialMedia
//
//  Created by chirag 04 on 19/02/13.
//  Copyright (c) 2013 chirag 04. All rights reserved.
//

#import "SMViewController.h"
#import "SMFacebook.h"
#import "REComposeViewController.h"
#import <Social/Social.h>
#import "SMSocialWrapper.h"
@interface SMViewController ()
@property (nonatomic, strong) SMFacebook *sm;
@end

@implementation SMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)socialExampleTwitterPressed
{
    
   /* if (SYSTEM_VERSION_LESS_THAN(@"6.0")) {
    REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
    composeViewController.title = @"Twitter";
    composeViewController.REComposeType = REComposeTypeTwitter;
    composeViewController.hasAttachment = NO;
    composeViewController.delegate = nil;
    composeViewController.text = @"Social media test";
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [composeViewController setCompletionHandler:^(REComposeViewController *composeViewController, REComposeResult result){
        if (result == REComposeResultCancelled) {
            [composeViewController dismissModalViewControllerAnimated:YES];
        }
        else if(result == REComposeResultPosted) {
            [composeViewController dismissModalViewControllerAnimated:YES];
        }
    }];
    [self presentViewController:composeViewController animated:YES completion:nil];
    }
   */
    
    SMSocialWrapper *sm = [[SMSocialWrapper alloc] initWithTitle:localizedString(@"Twitter") text:localizedString(@"Test text") image:nil url:nil imageUrl:nil];
    [sm postWithType:REComposeTypeTwitter inController:self];
}
- (void)socialExampleButtonPressed
{

    REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
    composeViewController.title = @"Facebook";
    composeViewController.REComposeType = REComposeTypeFacebook;
    composeViewController.hasAttachment = YES;
    composeViewController.delegate = nil;
    composeViewController.text = @"Social media test";
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [composeViewController setCompletionHandler:^(REComposeViewController *composeViewController, REComposeResult result){
        if (result == REComposeResultCancelled) {
            [composeViewController dismissModalViewControllerAnimated:YES];
        }
        else if(result == REComposeResultPosted) {
            [composeViewController dismissModalViewControllerAnimated:YES];
        }
    }];
    [self presentViewController:composeViewController animated:YES completion:nil];
}
- (IBAction)loginClicked:(id)sender {
    [self socialExampleTwitterPressed];
    
}

#pragma mark -
#pragma mark REComposeViewControllerDelegate

- (void)composeViewController:(REComposeViewController *)composeViewController didFinishWithResult:(REComposeResult)result
{
    [composeViewController dismissViewControllerAnimated:YES completion:nil];
    
    if (result == REComposeResultCancelled) {
        NSLog(@"Cancelled");
    }
    
    if (result == REComposeResultPosted) {
        NSLog(@"Text = %@", composeViewController.text);
       
    }
}
@end
