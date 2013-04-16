//
//  NSString+Extends.m
//  RegistrationModule
//
//  Created by iPhone Developer on 28/11/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import "NSString+Extends.h"

@implementation NSString (Extends)

- (NSString *)stringWithDevicePostFix {
    return [self stringByAppendingString:[AppUtility postFix]];
}

- (NSString *)stringNumberRound {
    NSRange r = [self rangeOfString:@"mi"];
    int k = [self integerValue] / 1000;
    if (k > 0) {
        if (r.length > 0) {
            return [[NSString stringWithFormat:@"%d",k] stringByAppendingString:@"K mi"];    
        }
        return [[NSString stringWithFormat:@"%d",k] stringByAppendingString:@"K"];
    }
    return self;
}

- (NSString *)trimString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)appendStringWith:(NSString *)string {
    return [NSString stringWithFormat:@"%@%@",self,string];
}
@end
