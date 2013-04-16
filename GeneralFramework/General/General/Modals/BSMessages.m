//
//  BSMessages.m
//  Beachory
//
//  Created by Brijesh 04 on 07/01/13.
//  Copyright (c) 2013 mycompany. All rights reserved.
//

#import "BSMessages.h"

@implementation BSMessages

+ (id)sharedInstance {
    static BSMessages *staticObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticObject = [[BSMessages alloc] init];
    });
    return staticObject;
}

- (NSString *)kMakeCall {
    if (_kMakeCall.length > 0) {
        return _kMakeCall;
    }
    return localizedString(@"kMakeCall");
}

- (NSString *)kAlert {
    if (_kAlert.length > 0) {
        return _kAlert;
    }
    return localizedString(@"kAlert");
}
- (NSString *)kCameraNA {
    if (_kCameraNA.length > 0) {
        return _kCameraNA;
    }
    return localizedString(@"kCameraNA");
}
- (NSString *)kPlzFillData {
    if (_kPlzFillData.length > 0) {
        return _kPlzFillData;
    }
    return localizedString(@"kPlzFillData");
}

- (NSString *)kWarning_FillProper {
    if (_kWarning_FillProper.length > 0) {
        return _kWarning_FillProper;
    }
    return localizedString(@"kWarning_FillProper");
}
- (NSString *)kWarning_EnterVldMail {
    if (_kWarning_EnterVldMail.length > 0) {
        return _kWarning_EnterVldMail;
    }
    return localizedString(@"kWarning_EnterVldMail");
}
- (NSString *)kWarning_DeviceSupport {
    if (_kWarning_DeviceSupport.length > 0) {
        return _kWarning_DeviceSupport;
    }
    return localizedString(@"kWarning_DeviceSupport");
}
- (NSString *)kWarningTimeout {
    if (_kWarningTimeout.length > 0) {
        return _kWarningTimeout;
    }
    return localizedString(@"kWarningTimeout");
}

- (NSString *)kEnterEmail {
    if (_kEnterEmail.length > 0) {
        return _kEnterEmail;
    }
    return localizedString(@"kEnterEmail");
}

- (NSString *)kErrorPass {
    if (_kErrorPass.length > 0) {
        return _kErrorPass;
    }
    return localizedString(@"kErrorPass");
}

- (NSString *)kAgree {
    if (_kAgree.length > 0) {
        return _kAgree;
    }
    return localizedString(@"kAgree");
}
@end
