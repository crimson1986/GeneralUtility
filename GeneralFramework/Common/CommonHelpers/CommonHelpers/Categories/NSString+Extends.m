//
//  NSString+Extends.m
//  RegistrationModule
//
//  Created by iPhone Developer on 28/11/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import "NSString+Extends.h"
#import "AppUtility.h"

@implementation NSString (Extends)

- (NSString *)stringWithDevicePostFix {
    return [self stringByAppendingString:[AppUtility postFix]];
}

- (NSString *)stringNumberRoundForUnit:(NSString *)unit {
    NSRange r = [self rangeOfString:unit];
    int k = [self integerValue] / 1000;
    if (k > 0) {
        if (r.length > 0) {
            return [[NSString stringWithFormat:@"%d",k] stringByAppendingString:[@"K " appendStringWith:unit]];
        }
        return [[NSString stringWithFormat:@"%d",k] stringByAppendingString:@"K"];
    }
    return self;
}

- (NSString *)trimString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)encodeString {
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)appendStringWith:(NSString *)string {
    return [NSString stringWithFormat:@"%@%@",self,string];
}

- (NSString *)stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}
@end
