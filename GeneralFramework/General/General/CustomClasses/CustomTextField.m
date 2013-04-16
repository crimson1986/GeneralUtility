//
//  RMTextField.m
//  RegistrationModule
//
//  Created by iPhone Developer on 30/11/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import "CustomTextField.h"

@interface CustomTextField ()
- (void)setupTextFields;
@end


@implementation CustomTextField

#pragma mark Launch method
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupTextFields];
}

/*
#pragma mark Custom Methods

- (NSString *)phUserName {
    return localizedString(@"kPHUserName");
}

- (NSString *)phPassword {
    switch (self.superview.tag) {
        case RMSuperViewLogin:
                return localizedString(@"kNullValue");
            break;
        case RMSuperViewRegistration:
            return localizedString(@"kNullValue");
            break;
        default:
            break;
    }
    return localizedString(@"kNullValue");
}

- (NSString *)phEmail {
    return localizedString(@"kEmailPHolder");
}

- (NSString *)phFName {
    return localizedString(@"kNullValue");
}

- (NSString *)phLName {
    return localizedString(@"kNullValue");
}

- (NSString *)phZipCode {
    return localizedString(@"kNullValue");
}
*/
- (void)commonCofiguration {
    self.backgroundColor = [UIColor clearColor];
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.borderStyle = UITextBorderStyleLine;
    self.textColor = [UIColor customInputTextColor];
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)configurePassword {
    self.secureTextEntry = YES;
}
- (void)configureEmail {
    self.keyboardType = UIKeyboardTypeEmailAddress;
}
- (void)configureFirstName {
    self.keyboardType = UIKeyboardTypeDefault;
}
- (void)configureLastName {
    self.keyboardType = UIKeyboardTypeDefault;
}
- (void)configureHintText {
    self.keyboardType = UIKeyboardTypeDefault;
    [self setValue:[UIColor customInputTextColor] forKeyPath:@"_placeholderLabel.textColor"];
}


/*
- (void)configureUserName {
    self.placeholder = self.phFName;
}
- (void)configureLastName {
    self.placeholder = self.phLName;
}
- (void)configureFirstName {
    self.placeholder = self.phFName;
}
- (void)configurePassword {
    self.placeholder = self.phPassword;
    self.secureTextEntry = YES;
}
- (void)configureEmail {
    self.placeholder = self.phEmail;
    self.keyboardType = UIKeyboardTypeEmailAddress;
}
- (void)configureZipCode {
    self.placeholder = self.phZipCode;
    self.keyboardType = UIKeyboardTypeNumberPad;
}
*/
/* Setup all textfield according to tag*/
- (void)setupTextFields {
    [self commonCofiguration];
    
    switch (self.tag) {
        case RMTextFieldTagPassword:
            [self configurePassword];
            break;
        case RMTextFieldTagEmail:
            [self configureEmail];
            break;
        case RMTextFieldTagFirstname:
            [self configureFirstName];
            break;
        case RMTextFieldTagLastname:
            [self configureLastName];
            break;
        case RMTextFieldTagHint:
            [self configureHintText];
            break;
        default:
            break;
    }
}

/*- (void) drawPlaceholderInRect:(CGRect)rect {
    [[UIColor colorWithRed:0 green:204/255.0 blue:255./255. alpha:1.0] setFill];
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:12]];
}*/
@end
