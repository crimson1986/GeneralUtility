//
//  AppUtility.h
//  RegistrationModule
//
//  Created by iPhone Developer on 28/11/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import "BSKeyboardControls.h"
@class CLLocationManager;
@class CLLocationManagerDelegate;

NSString *MIMEType (NSString *path);
NSString *localizedString (NSString *str);
UIImage *imageWithContentOfFile(NSString *imageName, NSString *ext);
BOOL isIphone5 (void);
@interface AppUtility : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager	* locationManager;
	CLLocation			* location;
    BOOL				  locationServicesEnabled;
}

//for current location
@property BOOL locationServicesEnabled;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) CLLocationManager *locationManager;

+ (BOOL)isAniPad;
+ (NSString *)postFix;
+ (void)doWringleAnimationOn:(UIView *)view;
+ (BSKeyboardControls *)setupKeyboardControls:(NSArray *)aTextFields forDelegate:(id)dg;

/* move view with keyboard */
+ (void)moveTextFiled:(UITextField *)textField inView:(UIView *)view distance:(CGFloat *)animatedDistance;
+ (void)moveTextFiled:(UITextField *)textField inScrollView:(UIScrollView *)view distance:(CGFloat *)animatedDistance;

/* reset original position of view*/
+ (void)resetView:(UIView *)view distance:(CGFloat)animatedDistance;
+ (void)resetScrollingOffset:(UIScrollView *)view distance:(CGFloat)animatedDistance;
+ (void)resetViewToZeroYCordinate:(UIView *)view;
+ (void)resetScrollingOffset:(UIScrollView *)view;

+ (CGSize)calculateHeightForText:(NSString *)text font:(UIFont *)font size:(CGSize)size;

+ (void)moveViewWithKeybourd:(UIView *)view distance:(CGFloat *)animatedDistance margin:(NSInteger)bottomMargin;




@end
