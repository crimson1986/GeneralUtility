//
//  BCAppShared.m
//  Beachory
//
//  Created by iPhone Developer on 06/12/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import "BCAppShared.h"
#import "MBProgressHUD.h"

@interface BCAppShared ()<MBProgressHUDDelegate>
{
    MBProgressHUD *_hud;
}
@end

@implementation BCAppShared

+ (id)sharedInstance {
    static BCAppShared *staticObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticObject = [[BCAppShared alloc] init];
    });
    return staticObject;
}

- (MBProgressHUD *)indicatorHud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] init];
        _hud.delegate = self;
        _hud.removeFromSuperViewOnHide = YES;
    }
    return _hud;
}

/*
 add indicator in window
 */

- (void)addInWindow:(UIWindow *)window {
    CGRect rect = [self indicatorHud].frame;
    rect.origin = CGPointZero;
    rect.size = window.bounds.size;
    [self indicatorHud].frame = rect;
    
    [window addSubview:[self indicatorHud]];
}
/*
 show indicator in given view
 */
- (void)showIndicatorWithText:(NSString *)text inWindow:(UIWindow *)window {
    [self addInWindow:window];
    [self indicatorHud].labelText = text;
    [[self indicatorHud] show:YES];
}

- (void)updateIndicatorText:(NSString *)text {
    [self indicatorHud].labelText = text;
}
/*
 show hint in given window
 */
- (void)showHintWithText:(NSString *)text inWindow:(UIWindow *)window {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
	
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.detailsLabelText = text;
	hud.margin = 10.f;
	hud.yOffset = 0.f;
	hud.removeFromSuperViewOnHide = YES;
	
	[hud hide:YES afterDelay:1];
}
/*
 hide indicator
 */
- (void)hideIndicator {
    [[self indicatorHud] removeFromSuperview];
    [[self indicatorHud] hide:YES];
    _hud = nil;
}



#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[_hud removeFromSuperview];
	_hud = nil;
}


@end
