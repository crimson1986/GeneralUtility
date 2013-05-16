//
//  SMGPlus.m
//  SocialMedia
//
//  Created by chirag 04 on 25/02/13.
//  Copyright (c) 2013 chirag 04. All rights reserved.
//

#import "SMGPlus.h"

@implementation SMGPlus

/*
 *Initialize
 */
- (id)initWithUrl:(NSURL *)url
         thumbUrl:(NSURL *)thumbUrl
       deepLinkId:(NSString *)dId
    deepLinkTitle:(NSString *)dTitle
     deepLinkDesc:(NSString *)dLinkDesc
 sharePrefillText:(NSString *)shareText {
    
    self = [super init];
    if (self) {
        self.url = url;
        self.thumbUrl = thumbUrl;
        self.deepLinkID = dId;
        self.deepLinkTitle = dTitle;
        self.deepLinkDescription = dLinkDesc;
        self.sharePrefillText = shareText;
        
        _share = [[GPPShare alloc] initWithClientID:kClientID];
        _share.delegate = self;
    }
    return self;
}

#pragma mark -

/*
 *Share
 */

// Share button Clicked...
- (void)shareToGPlus {
    id<GPPShareBuilder> shareBuilder = [_share shareDialog];
    
//    NSString *inputURL = self.url;
    NSURL *urlToShare = self.url?self.url : nil;
    if (urlToShare) {
        shareBuilder = [shareBuilder setURLToShare:urlToShare];
    }
    
    if (self.deepLinkID) {
        shareBuilder = [shareBuilder setContentDeepLinkID:self.deepLinkID];
        NSString *title = self.deepLinkTitle;
        NSString *description = self.deepLinkDescription;
        if (title && description) {
            NSURL *thumbnailURL = self.thumbUrl;
            shareBuilder = [shareBuilder setTitle:title
                                      description:description
                                     thumbnailURL:thumbnailURL];
        }
    }
    
    NSString *inputText = self.sharePrefillText;
    NSString *text = [inputText length] ? inputText : nil;
    if (text) {
        shareBuilder = [shareBuilder setPrefillText:text];
    }
    
    if (![shareBuilder open]) {
        DLog(@"Status: Error (see console).");
    }
}

#pragma mark - GPPShareDelegate
// Delegate method that is called after sharing process is completed...
- (void)finishedSharing:(BOOL)shared {
    NSString *text = shared ? @"Success" : @"Canceled";
    DLog(@"%@",[NSString stringWithFormat:@"Status: %@", text]);
}
@end
