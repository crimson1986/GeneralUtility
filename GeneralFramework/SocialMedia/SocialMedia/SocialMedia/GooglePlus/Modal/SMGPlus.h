//
//  SMGPlus.h
//  SocialMedia
//
//  Created by chirag 04 on 25/02/13.
//  Copyright (c) 2013 chirag 04. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPPSignIn.h"
#import "GPPSignInButton.h"
#import "GPPShare.h"
@interface SMGPlus : NSObject <GPPShareDelegate>
{
    GPPShare *_share;
}
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSURL *thumbUrl;
@property (strong, nonatomic) NSString *deepLinkID;
@property (strong, nonatomic) NSString *deepLinkTitle;
@property (strong, nonatomic) NSString *deepLinkDescription;
@property (strong, nonatomic) NSString *sharePrefillText;

- (id)initWithUrl:(NSURL *)url
         thumbUrl:(NSURL *)thumbUrl
       deepLinkId:(NSString *)dId
    deepLinkTitle:(NSString *)dTitle
     deepLinkDesc:(NSString *)dLinkDesc
 sharePrefillText:(NSString *)shareText;

//share to gplus which is seted
- (void)shareToGPlus;
@end
