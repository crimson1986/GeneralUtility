

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