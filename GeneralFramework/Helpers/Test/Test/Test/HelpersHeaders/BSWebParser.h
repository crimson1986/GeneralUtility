//
//  BSWebParser.h
//  Beachory
//
//  Created by chirag 04 on 10/12/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
extern NSString *kAppBaseUrl;

@interface BSWebParser : AFHTTPClient
+ (id)sharedInstanse;
- (void)multipartDataUploadWithMethod:(NSString *)method
                            parameter:(NSDictionary *)parameters
                                 path:(NSString *)path
                                 data:(NSData *)data
                             fileName:(NSString *)fileName
                            serverTag:(NSString *)file
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end