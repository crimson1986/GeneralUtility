//
//  SMAlertView.h
//  SocialMedia
//
//  Created by chirag 04 on 25/02/13.
//  Copyright (c) 2013 chirag 04. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SMAlertView;
typedef void (^SMCompletionHandler)(SMAlertView *alert, NSInteger buttonIndex);
@interface SMAlertView : UIAlertView
@property (nonatomic, copy) SMCompletionHandler completionHandler;
@end
