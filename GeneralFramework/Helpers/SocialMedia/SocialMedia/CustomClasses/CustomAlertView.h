//
//  SMAlertView.h
//  SocialMedia
//
//  Created by chirag 04 on 25/02/13.
//  Copyright (c) 2013 chirag 04. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomAlertView;
typedef void (^CACompletionHandler)(CustomAlertView *alert, NSInteger buttonIndex);
@interface CustomAlertView : UIAlertView
@property (nonatomic, copy) CACompletionHandler completionHandler;
@end
