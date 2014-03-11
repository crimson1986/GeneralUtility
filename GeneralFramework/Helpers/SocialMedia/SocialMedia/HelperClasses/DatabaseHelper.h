//
//  DatabaseHelper.h
//  Helpers
//
//  Created by Chirag shah on 11/03/14.
//  Copyright (c) 2014 Brijesh 04. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseHelper : NSObject
+ (instancetype)sharedInstance;
@end
