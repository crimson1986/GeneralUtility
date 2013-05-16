//
//  SMSocialWrapper.h
//  SocialMedia
//
//  Created by chirag 04 on 22/02/13.
//  Copyright (c) 2013 chirag 04. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REComposeViewController.h"
@interface SMSocialWrapper : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *attachedImage;
@property (nonatomic, strong) NSURL *url;//must needed for pinterest
@property (nonatomic, strong) NSString *tweetCC;
@property (nonatomic, strong) NSURL *imageUrl;//must needed for pinterest

- (id)initWithTitle:(NSString *)title
               text:(NSString *)text
              image:(UIImage *)image
                url:(NSURL *)url
           imageUrl:(NSURL *)imgUrl;
//Use for twitter and facebook custom compose sheet
- (void)postWithType:(REComposeType)type inController:(UIViewController *)vc;

//share for pinterest
- (void)pinItWithImageUrl:(NSURL *)imageUrl inController:(UIViewController *)vc;
@end
