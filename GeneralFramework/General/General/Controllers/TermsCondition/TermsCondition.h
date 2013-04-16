//
//  RMTermsCondition.h
//  RegistrationModule
//
//  Created by iPhone Developer on 03/12/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *kTermsAndCondition;
extern NSString *kPrivacyPolicy;
@interface TermsCondition : CustomViewController
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIButton *checkBox;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@end
