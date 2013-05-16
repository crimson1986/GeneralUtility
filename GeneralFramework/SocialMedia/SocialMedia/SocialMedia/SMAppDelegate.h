//
//  SMAppDelegate.h
//  SocialMedia
//
//  Created by chirag 04 on 19/02/13.
//  Copyright (c) 2013 chirag 04. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMViewController;

@interface SMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SMViewController *viewController;
+ (SMAppDelegate *)sharedInstance;
@end
