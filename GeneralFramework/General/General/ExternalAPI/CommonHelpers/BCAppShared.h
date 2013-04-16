//
//  BCAppShared.h
//  Beachory
//
//  Created by iPhone Developer on 06/12/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^Success)(id result);
typedef void (^Failed)(id result);

@interface BCAppShared : NSObject
{

    Success _successResult;
    Failed _failed;

}

@property (copy) Success successResult;
@property (copy) Failed failed;

+ (id)sharedInstance;
- (void)showIndicatorWithText:(NSString *)text inWindow:(UIWindow *)window;
- (void)showHintWithText:(NSString *)text inWindow:(UIWindow *)window;


- (void)hideIndicator;

- (void)updateIndicatorText:(NSString *)text;

@end

