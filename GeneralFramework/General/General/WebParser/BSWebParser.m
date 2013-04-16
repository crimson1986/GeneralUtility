//
//  BSWebParser.m
//  Beachory
//
//  Created by Brijesh 04 on 10/12/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import "BSWebParser.h"


/* Add base url here for the application */
NSString *kAppBaseUrl = @"http://projects.spinxweb.net/BookTraderServices/BookTrader.svc/";

@implementation BSWebParser

/* Create singleton instanse */
+ (id)sharedInstanse {
    static BSWebParser *sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[BSWebParser alloc] initWithBaseURL:[NSURL EncodedURLWithString:kAppBaseUrl]];
    });
    return sharedObject;
}

/* create instanse with base url */
- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setDefaultHeader:@"X-Requested-With" value:@"XMLHttpRequest"];
        [self setParameterEncoding:AFJSONParameterEncoding];
    }
    return self;
}

/* Whenever we need to upload document, images etc then we have to use this.
 @method should be "POST", "PUT","DELETE",
 @parameter is header key pair value for server.
 @path should be server url without base url
 @filename by which you want to save on server
 @file through server can access file
 @data NSData which you want to upload
 */
- (void)multipartDataUploadWithMethod:(NSString *)method
                            parameter:(NSDictionary *)parameters
                                 path:(NSString *)path
                                 data:(NSData *)data
                             fileName:(NSString *)fileName
                            serverTag:(NSString *)file
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSMutableURLRequest *request = [self multipartFormRequestWithMethod:method path:path parameters:parameters constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        [formData appendPartWithFileData:data name:file fileName:fileName mimeType:MIMEType(@"image/png")];
    }];
    
    AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:success failure:failure];
    [operation start];
}

@end
