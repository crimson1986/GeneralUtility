//
//  SMSocialWrapper.m
//  SocialMedia
//
//  Created by Brijesh 04 on 22/02/13.
//  Copyright (c) 2013 Brijesh 04. All rights reserved.
//

#import "SMSocialWrapper.h"
#import <Social/Social.h>
#import "SMAlertView.h"
#import "PinterestViewController.h"

@implementation SMSocialWrapper

- (id)initWithTitle:(NSString *)title
               text:(NSString *)text
              image:(UIImage *)image
                url:(NSURL *)url
           imageUrl:(NSURL *)imgUrl {
    self = [super init];
    if (self) {
        self.text = text;
        self.url = url;
        self.attachedImage = image;
        self.title = title;
        self.imageUrl = imgUrl;
    }
    return self;
}


// PINTEREST
- (void)pinItInController:(UIViewController *)vc {
    [self pinItWithImageUrl:self.imageUrl inController:vc];
}
- (void)pinItWithImageUrl:(NSURL *)imageUrl inController:(UIViewController *)vc
{
    NSAssert(_url, @"Url must not be nil.");
    NSAssert(imageUrl, @"ImageUrl must not be nil for Pinterest.");
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"pinit12://pinterest.com/pin/create/bookmarklet/?url=%@&media=%@&description=%@\"", self.url, imageUrl, self.text]];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        // ask for download the app
        SMAlertView *alert = [[SMAlertView alloc] initWithTitle:NSLocalizedString(@"Pinterest", @"")
                                                        message:NSLocalizedString(@"Would you like to download Pinterest Application to share?", @"")
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                              otherButtonTitles:NSLocalizedString(@"App Store", @""), NSLocalizedString(@"Open pinterest.com", @""), nil];
        [alert setCompletionHandler:^(SMAlertView *alert,NSInteger buttonIndex){
            switch (buttonIndex)
            {
                case 0: // cancel
                    
                    break;
                    
                case 1: // download the app
                {
                    DLog(@"");
                    NSString *stringURL = @"http://itunes.apple.com/us/app/pinterest/id429047995?mt=8";
                    NSURL *url = [NSURL URLWithString:stringURL];
                    [[UIApplication sharedApplication] openURL:url];
                }
                    break;
                    
                case 2: // open pinterest.com
                {
                    DLog(@"");
                    PinterestViewController *pinVC = [[PinterestViewController alloc] init:self.url imageUrl:imageUrl description:self.text];
                    [vc presentModalViewController:pinVC animated:YES];
                    
#if !__has_feature(objc_arc)
                    [pinVC autorelease];
#endif
                }
                    break;
                    
            }
        }];
        
        [alert show];
#if !__has_feature(objc_arc)
        [alert release];
#endif
        
    }
}

/*
 *iOS version 6 and above
 */
- (void)postOnFacebookInController:(UIViewController *)vc {
    SLComposeViewController *socialComposer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    if (self.title != nil)
        [socialComposer setTitle:self.title];
    if (self.text != nil)
        [socialComposer setInitialText:self.text];
    if (self.url != nil)
        [socialComposer addURL:self.url];
    if (self.attachedImage != nil)
        [socialComposer addImage:self.attachedImage];
    
    __block SLComposeViewController *sc = socialComposer;
    [socialComposer setCompletionHandler:^(SLComposeViewControllerResult result){
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                
                
                break;
            case SLComposeViewControllerResultDone:
                
                
                break;
            default:
                
                break;
        }
        
        [sc dismissViewControllerAnimated:YES completion:nil];
    }];
    [vc presentViewController:socialComposer animated:YES completion:nil];
}
//twitter post
- (void)postOnTwitterInController:(UIViewController *)vc {
    SLComposeViewController *socialComposer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    // IMAGE
    if (self.attachedImage != nil)
        [socialComposer addImage:self.attachedImage];
    
    // TEXT
    if (self.text != nil)
    {
        // URL AND TWEETCC
        // creo el formato del texto a twittear
        NSString *format    = @"%@";
        if (self.url != nil)
            format          = [format stringByAppendingFormat:@" %@", [self.url absoluteString]];
        if (self.tweetCC != nil)
            format          = [format stringByAppendingFormat:@" %@", self.tweetCC];
        
        
        // TEXT
        NSUInteger idx      = self.text.length;
        
        while([self.text hasPrefix:@" "])
            self.text = [self.text substringFromIndex:1];
        while([self.text hasSuffix:@" "])
        {
            idx       = idx-1;
            self.text = [self.text substringToIndex:idx];
        }
        // create message
        NSString *message   = [NSString stringWithFormat:format, [NSString stringWithFormat:@"%@", [self.text substringToIndex:idx]]];
        
        
        // if the message is bigger than 140 characters, then cut the message
        while (![socialComposer setInitialText:message])
        {
            idx -= 5;
            if (idx > 5)
            {
                message = [NSString stringWithFormat:format, [NSString stringWithFormat:@"%@…", [self.text substringToIndex:idx]]];
            }
            else
            {
                [socialComposer setInitialText:[self.url absoluteString]];
                break;
            }
        }
    }
    else
    {
        [socialComposer setInitialText:[self.url absoluteString]];
    }
    
    __block SLComposeViewController *sc = socialComposer;
    
    [socialComposer setCompletionHandler:^(SLComposeViewControllerResult result){
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                
                break;
            case SLComposeViewControllerResultDone:
                
                break;
            default:
                break;
        }
        
        [sc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [vc presentViewController:socialComposer animated:YES completion:nil];
}

/*
 * common post for twitter and facebook
 */
- (void)postCommonForType:(REComposeType)type inController:(UIViewController *)vc {
    if (SYSTEM_VERSION_LESS_THAN(@"6.0")) {
        REComposeViewController *composeViewController = [[REComposeViewController alloc] initWithType:type];
//        composeViewController.REComposeType = type;
        composeViewController.hasAttachment = self.attachedImage?YES:NO;
        composeViewController.delegate = nil;
        composeViewController.text = self.text;
        composeViewController.url = self.url;
        vc.modalPresentationStyle = UIModalPresentationCurrentContext;
        composeViewController.title = self.title;
        
        [composeViewController setCompletionHandler:^(REComposeViewController *composeViewController, REComposeResult result){
            if (result == REComposeResultCancelled) {
                [composeViewController dismissModalViewControllerAnimated:YES];
            }
            else if(result == REComposeResultPosted) {
                [composeViewController dismissModalViewControllerAnimated:YES];
            }
        }];
        [vc presentViewController:composeViewController animated:YES completion:nil];
    }
    else {
        //code for ios 6.0
        switch (type) {
            case REComposeTypeFacebook:
                [self postOnFacebookInController:vc];
                break;
            case REComposeTypeTwitter:
                [self postOnTwitterInController:vc];
                break;
            default:
                break;
        }
    }
}
/*
 * post
 */
- (void)postWithType:(REComposeType)type inController:(UIViewController *)vc {
    switch (type) {
        case REComposeTypeFacebook:
            [self postCommonForType:type inController:vc];
            break;
        case REComposeTypeTwitter:
            [self postCommonForType:type inController:vc];
            break;
        case REComposeTypePinterest:
            [self pinItInController:vc];
            break;
        default:
            break;
    }
}

- (void)dealloc {
    DLog(@"");
}
@end
