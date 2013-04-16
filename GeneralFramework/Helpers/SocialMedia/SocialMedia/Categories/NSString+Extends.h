//
//  NSString+Extends.h
//  RegistrationModule
//
//  Created by iPhone Developer on 28/11/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extends)
- (NSString *)stringWithDevicePostFix;
- (NSString *)stringNumberRound;
- (NSString *)trimString;
- (NSString *)appendStringWith:(NSString *)string;
@end
