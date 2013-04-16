//
//  Defaults.h
//  RegistrationModule
//
//  Created by Brijesh 04 on 27/11/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//


#ifdef DEBUG
#    define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#    define DLog(...) /* */
#endif

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
