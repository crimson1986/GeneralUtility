//
//  SMTwitter.h
//  SocialMedia
//
//  Created by chirag 04 on 21/02/13.
//  Copyright (c) 2013 chirag 04. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHSTwitterEngine.h"
@interface SMTwitter : FHSTwitterEngine
// initialized
- (id)initTwitter;

// post tweet
- (void)postTweet:(NSString *)tweet result:(void (^)(NSError *result))result;

//get user informations when ever you pass user
//like [NSArray arrayWithObjects:@"fhsjaagshs", @"twitter", nil]
- (id)getUserinformationForUsers:(NSArray *)user;

//Get followers 
- (NSArray *)followers;

//Get username
- (NSString *)userName;

//logout
- (void)logout;

//check authorized or not
- (BOOL)isAuthorized;

//open twitter login panel
- (void)openFromController:(UIViewController *)vc withResult:(void (^)(bool result))result;

// post tweet and image
- (void)postTweet:(NSString *)tweet withImageData:(NSData *)theData result:(void (^)(NSError *result))result;
@end
