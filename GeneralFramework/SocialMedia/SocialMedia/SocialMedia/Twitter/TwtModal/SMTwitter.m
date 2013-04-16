//
//  SMTwitter.m
//  SocialMedia
//
//  Created by Brijesh 04 on 21/02/13.
//  Copyright (c) 2013 Brijesh 04. All rights reserved.
//

#import "SMTwitter.h"
#define kConsumerKey @"3QTyyoEBCveE6iRbAj7Wg"
#define kSecretKey @"KjTCM2qHYJdmhIhnsJtycPaUDWbLXD6BSHqiMlkU"
@implementation SMTwitter

/* 
 *initialize with keys 
 */

- (id)initTwitter {
    self = [super initWithConsumerKey:kConsumerKey andSecret:kSecretKey];
    if (self) {
        //do somthing
    }
    return self;
}

/*
 * post tweet over twitter if success return nil in block result else error
 */

- (void)postTweet:(NSString *)tweet result:(void (^)(NSError *result))result {
    dispatch_async(GCDBackgroundThread, ^{
        @autoreleasepool {
            __block NSError *returnCode = nil;
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            dispatch_sync(GCDMainThread, ^{
                returnCode = [super postTweet:tweet];
            });
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            dispatch_sync(GCDMainThread, ^{
                result(returnCode);
            });
        }
    });
}

/*
 post tweet and image combine
 */
- (void)postTweet:(NSString *)tweet withImageData:(NSData *)theData result:(void (^)(NSError *result))result {
    dispatch_async(GCDBackgroundThread, ^{
        @autoreleasepool {
            __block NSError *returnCode = nil;
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            dispatch_sync(GCDMainThread, ^{
                returnCode = [super postTweet:tweet withImageData:theData];
            });
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            dispatch_sync(GCDMainThread, ^{
                result(returnCode);
            });
        }
    });
}
/*
 * get user informations
 */
- (id)getUserinformationForUsers:(NSArray *)user {
    return [super getUserInformationForUsers:user areUsers:YES];
}

/*
 * Get followers
 */
- (NSArray *)followers {
    return [super getFollowers];
}

/*
 * Get user name
 */
- (NSString *)userName {
    [super loadAccessToken];
    return [super loggedInUsername];
}

/*
 * logout from twitter
 */

- (void)logout {
    [super clearAccessToken];
}
/*
 * Check user is authorized
 */
- (BOOL)isAuthorized {
    [super loadAccessToken];
    return [super isAuthorized];
}
/*
 * open login controller for twitter
 */
- (void)openFromController:(UIViewController *)vc withResult:(void (^)(bool result))result {
    [vc presentModalViewController:[super OAuthLoginWindowWithResult:result] animated:YES];
}
@end
