//
//  NSObject+Utility.h
//  RegistrationModule
//
//  Created by iPhone Developer on 28/11/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Utility)
- (NSArray *)superclasses;
+ (BOOL)classExists:(NSString *)className;
+ (id)instanceOfClassNamed:(NSString *)className;
+ (id)instanceOfNibNamed:(NSString *)NibName;

+ (id)loadNibNamed:(NSString *)NibName;
@end
