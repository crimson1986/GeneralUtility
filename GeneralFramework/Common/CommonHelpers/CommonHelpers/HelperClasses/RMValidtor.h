//
//  RMValidtor.h
//  RegistrationModule
//
//  Created by chirag 04 on 27/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMValidtor : NSObject

+ (BOOL)isEmptyTexts:(NSArray *)fields;

+ (BOOL)isEmptyText:(NSString *)field;
+ (BOOL)validateEmailWithString:(NSString*)email;

@end
