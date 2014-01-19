//
//  Headers.h
//  SocialMedia
//
//  Created by chirag 04 on 21/02/13.
//  Copyright (c) 2013 chirag 04. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#ifdef DEBUG
#    define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#    define DLog(...) /* */
#endif

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

#import "AppUtility.h"
#import "NSString+Extends.h"
#import "NSDictionary+ST.h"
#import "NSObject+Utility.h"
#import "UIColor+Extends.h"
#import "UIImage+Tools.h"
#import "UIViewExtensions.h"
#import "NSURL+Extend.h"
#import "UIViewControllerExtensions.h"
#import "BCAppShared.h"
#import "RMValidtor.h"
#import "CustomAlertView.h"
