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

//round digits with K
- (NSString *)stringNumberRoundForUnit:(NSString *)unit;

//trim whitspaces
- (NSString *)trimString;

//append string
- (NSString *)appendStringWith:(NSString *)string;

// string encoding
- (NSString *)encodeString;
@end


