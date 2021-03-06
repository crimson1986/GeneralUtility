//
//  CMReachability.h
//  General
//
//  Created by chirag 04 on 01/03/13.
//  Copyright (c) 2013 chirag 04. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CMReachabilityCallback) (NSString *string);
@interface CMReachability : NSObject
//register reachability
- (void)registerReachabilityWithCallBack:(CMReachabilityCallback)callBk;

//remove reachbility
- (void)removeReachability;
@end
