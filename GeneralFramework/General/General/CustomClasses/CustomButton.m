//
//  RMButton.m
//  RegistrationModule
//
//  Created by iPhone Developer on 30/11/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import "CustomButton.h"


@interface CustomButton ()
- (void)setupButtons;
@end

@implementation CustomButton
@synthesize buttonDelegate = _buttonDelegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupButtons];
}
/*
#pragma Custom Methods

- (NSString *)continueTitle {
    return localizedString(@"kReset");
}

- (NSString *)loginTitle {
    return localizedString(@"kLogin");
}

- (NSString *)registerTitle {
    switch (self.superview.tag) {
        case RMSuperViewLogin:
           return localizedString(@"kRegisterHere"); 
            break;
        case RMSuperViewRegistration:
            return localizedString(@"kRegister");
            break;
        default:
            break;
    }
    return localizedString(@"kRegisterHere");
}
*/

/* return loaclized button title */
/*
- (NSString *)getButtonTitle {
    NSString *_title = @"";
    switch (self.tag) {
        case RMButtonTypeCall:
            _title = localizedString(@"kCall");
            break;
        case RMButtonTypeSubmit:
            _title = localizedString(@"kSubmit");
            break;
        default:
            break;
    }
    return _title;
}
*/

- (SEL)getSelectotMethod {
    SEL _methods = @selector(action:);
    return _methods;
}

- (UIColor *)getTitleLableTextColor {
    UIColor *_color = [UIColor colorWithRed:9.0/255.0 green:173.0/255.0 blue:200.0/255.0 alpha:1.0];
    return _color;
}

- (UIColor *)getButtonBackGroundColor {
    UIColor *_color = [UIColor clearColor];
    return _color;
}

/* return image name according to button tag */
- (NSString *)imageNameForLink {
    NSString *_imgName = @"";
    /*switch (self.superview.tag) {
        case RMSuperViewLogin:
            _imgName = @"login-forgotpass";
            break;
        case RMSuperViewRegistration:
            _imgName = @"terms-condition";
            break;
        default:
            break;
    }*/
    return _imgName;
}

/* return image for button */
- (UIImage *)getImage {
    UIImage *_image = nil;
    /*switch (self.tag) {
        case RMButtonTypeCall:
            _image = [UIImage imageNamed:@"searchbook-btn"];
            break;
        case RMButtonTypeSubmit:
            _image = [UIImage imageNamed:@"listbook-btn"];
            break;
        default:
            break;
    }*/
    return _image;
}
/*Add target and add other features*/
- (void)commonLayout {
    [self setBackgroundColor:[self getButtonBackGroundColor]];
 //   [self setTitle:self.getButtonTitle forState:UIControlStateNormal];
    //[self setTitleColor:[self getTitleLableTextColor] forState:UIControlStateNormal];
    [self addTarget:self action:[self getSelectotMethod] forControlEvents:UIControlEventTouchUpInside];
    [self setImage:[self getImage] forState:UIControlStateNormal];
    [self sizeToFit];
}


/*setup buttons according to tags*/
- (void)setupButtons {
    [self commonLayout];
}


/* Action selected button */

- (void)action:(id)sender {
    if ([self.buttonDelegate respondsToSelector:@selector(action:)]) {
        [self.buttonDelegate action:self.tag];
    }
}


@end
