//
//  NSURL+Extend.h
//  WebParser
//
//  Created by Brijesh 04 on 10/12/12.
//  Copyright (c) 2012 Brijesh 04. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Extend)
+ (NSURL *)EncodedURLWithString:(NSString *)string;
@end