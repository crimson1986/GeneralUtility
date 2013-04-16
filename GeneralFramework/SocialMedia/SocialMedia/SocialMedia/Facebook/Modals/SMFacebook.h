//
//  SMFacebook.h
//  SocialMedia
//
//  Created by Brijesh 04 on 19/02/13.
//  Copyright (c) 2013 Brijesh 04. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

typedef void (^FBCompletionHandler)(FBSession *session,
FBSessionState status,
NSError *error);

@interface SMFacebook : NSObject
@property (nonatomic, strong) FBSession *session;

//check session is open
- (BOOL)isOpen;
// initialized
- (id)initWithHandler:(FBCompletionHandler)handler;
- (id)initWithAppId:(NSString *)appId delegate:(id)fbDelegate completionHandler:(FBCompletionHandler)handler;

- (void)openSessionIfNeededWithHandler:(FBCompletionHandler)handler;

- (void)postOnFacebookForSession:(FBSession *)session
                       graphPath:(NSString *)gPath
                      parameters:(NSDictionary *)p
               completionHandler:(FBRequestHandler)handler;
@end
