//
//  SMFacebook.m
//  SocialMedia
//
//  Created by chirag 04 on 19/02/13.
//  Copyright (c) 2013 chirag 04. All rights reserved.
//
//TODO: Use your Facebook AppId
#define kFBAppId @"213554575366497"
#import "SMFacebook.h"
@interface SMFacebook ()
@property (nonatomic, copy) FBCompletionHandler completionHandler;
@end
@implementation SMFacebook


/*
 Add permission to access
 */
- (NSArray *)permission {
    return [NSArray arrayWithObjects:@"publish_stream",@"read_friendlists",@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins,email",@"upload_video", nil];
}

- (BOOL)isOpen {
    return self.session.isOpen;
}
/*
 Open session if needed
 */
- (void)openSessionIfNeededWithHandler:(FBCompletionHandler)handler {
    if (!self.isOpen) {
        [self.session openWithBehavior:FBSessionLoginBehaviorForcingWebView completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            handler(session,status,error);
        }];
    }
    else {
        handler(self.session,self.session.state,nil);
    }
}
/*
 create session with default chache policy
 */
- (FBSession *)session {
    if (!_session) {
        _session = [[FBSession alloc] initWithAppID:kFBAppId permissions:[self permission] urlSchemeSuffix:nil tokenCacheStrategy:0];
    }
    return _session;
}

/*
 initialized with default appid
 */
- (id)initWithHandler:(FBCompletionHandler)handler {
    self = [super init];
    if (self) {
        self.completionHandler = handler;
        [self openSessionIfNeededWithHandler:self.completionHandler];
    }
    return self;
}
/*
 initialize facebook with give appId
 login with facebook account
 */

- (id)initWithAppId:(NSString *)appId delegate:(id)fbDelegate completionHandler:(FBCompletionHandler)handler {
    self = [super init];
    if (self) {
        self.completionHandler = handler;
        [self openSessionIfNeededWithHandler:self.completionHandler];
    }
    return self;
}

/*
 logout from facebook account
 */
- (void)logout {
    [_session closeAndClearTokenInformation];
    _session = nil;
}

/*
 *Post image with path @"me/photo" and post video and text also
 *pass within deictionary related para
 */
- (void)postOnFacebookForSession:(FBSession *)session
                       graphPath:(NSString *)gPath
                      parameters:(NSDictionary *)p
               completionHandler:(FBRequestHandler)handler {
    FBRequestConnection *newConnection = [[FBRequestConnection alloc] init];
    FBRequest *request = [[FBRequest alloc] initWithSession:session
                                                  graphPath:gPath
                                                 parameters:p
                                                 HTTPMethod:@"POST"];
    
    [newConnection addRequest:request completionHandler:handler];
    
    [newConnection start];
}
@end
