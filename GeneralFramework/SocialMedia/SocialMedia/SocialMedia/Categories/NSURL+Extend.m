//
//  NSURL+Extend.m
//  WebParser
//
//  Created by chirag 04 on 10/12/12.
//  Copyright (c) 2012 chirag 04. All rights reserved.
//

#import "NSURL+Extend.h"

@implementation NSURL (Extend)

+ (NSURL *)EncodedURLWithString:(NSString *)string {
    NSURL *url = [NSURL URLWithString:[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return url;
}

@end
