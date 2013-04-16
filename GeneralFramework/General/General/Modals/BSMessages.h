//
//  BSMessages.h
//  Beachory
//
//  Created by Brijesh 04 on 07/01/13.
//  Copyright (c) 2013 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSMessages : NSObject

@property (nonatomic, strong) NSString *kCameraNA;
@property (nonatomic, strong) NSString *kPlzFillData;
@property (nonatomic, strong) NSString *kWarning_FillProper;
@property (nonatomic, strong) NSString *kWarning_EnterVldMail;
@property (nonatomic, strong) NSString *kWarning_DeviceSupport;
@property (nonatomic, strong) NSString *kWarningTimeout;
@property (nonatomic, strong) NSString *kEnterEmail;

/* Now using */
@property (nonatomic, strong) NSString *kAlert;
@property (nonatomic, strong) NSString *kMakeCall;
@property (nonatomic, strong) NSString *kErrorPass;
@property (nonatomic, strong) NSString *kAgree;
+ (id)sharedInstance;
@end
