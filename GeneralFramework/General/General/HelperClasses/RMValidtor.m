//
//  RMValidtor.m
//  RegistrationModule
//
//  Created by Brijesh 04 on 27/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RMValidtor.h"

@implementation RMValidtor


/*
 check strings array any string is empty if any one string is empty return yes
 */
+ (BOOL)isEmptyTexts:(NSArray *)fields {
    for (UITextField *field in fields) {
        if (!field.text || ![field.text isKindOfClass:[NSString class]] || [field.text trimString].length == 0) {
            return YES;
        }
    }
    
    return NO;
}
/*
 check string is empty or not if empty return yes
 */
+ (BOOL)isEmptyText:(NSString *)field {
    if (field && [field isKindOfClass:[NSString class]] && [field trimString].length > 0) {
        return NO;
    }
    return YES;
}
/*
 validate email string
 */
+ (BOOL)validateEmailWithString:(NSString*)email
{
    if (![RMValidtor isEmptyText:email]) {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
        return [emailTest evaluateWithObject:email];    
    }
    return NO;
}

@end
