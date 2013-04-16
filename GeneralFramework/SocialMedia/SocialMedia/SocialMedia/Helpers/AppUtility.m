//
//  AppUtility.m
//  RegistrationModule
//
//  Created by iPhone Developer on 28/11/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import "AppUtility.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
/* pass file name with extension it will return mime type for you */

NSString *MIMEType (NSString *path)
{
    if (!path) {
        return nil;
    }
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef mimeType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!mimeType) {
        return @"application/octet-stream";
    }
    return (__bridge_transfer NSString *)mimeType;
}
/* return localized string */
NSString *localizedString (NSString *str) {
    return NSLocalizedStringFromTable(str, @"Localized",@"");//NSLocalizedString(str, @"");
}

/*
 return image from bundle file which is not chace
 */
UIImage *imageWithContentOfFile(NSString *imageName, NSString *ext) {
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:ext]];
    return image;
}

@implementation AppUtility

@synthesize locationManager , locationServicesEnabled , location;

/*device checking*/
+ (BOOL)isAniPad
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    else
        return NO;
} 

/* Get string for append at trail related device */
+ (NSString *)postFix {
    if ([AppUtility isAniPad]) {
        return @"_iPad";
    }
    else {
        return @"";//_iPhone
    }
    
    return nil;
}

#pragma mark animation methods



+ (void)doWringleAnimationOn:(UIView *)view
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:3];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([view center].x - 5.0f, [view center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([view center].x + 5.0f, [view center].y)]];
    [[view layer] addAnimation:animation forKey:@"position"];
    
}

#pragma mark keyboard control method
+ (BSKeyboardControls *)setupKeyboardControls:(NSArray *)aTextFields forDelegate:(id)dg
{
    // Initialize the keyboard controls
    BSKeyboardControls *keyboardControls = [[BSKeyboardControls alloc] init];
    
    // Set the delegate of the keyboard controls
    keyboardControls.delegate = dg;
    
    // Add all text fields you want to be able to skip between to the keyboard controls
    // The order of thise text fields are important. The order is used when pressing "Previous" or "Next"
    keyboardControls.textFields = aTextFields;
    
    // Set the style of the bar. Default is UIBarStyleBlackTranslucent.
    keyboardControls.barStyle = UIBarStyleBlackTranslucent;
    
    // Set the tint color of the "Previous" and "Next" button. Default is black.
    keyboardControls.previousNextTintColor = [UIColor blackColor];
    
    // Set the tint color of the done button. Default is a color which looks a lot like the original blue color for a "Done" butotn
    keyboardControls.doneTintColor = [UIColor colorWithRed:34.0/255.0 green:164.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    // Set title for the "Previous" button. Default is "Previous".
    keyboardControls.previousTitle = localizedString(@"kPrevious");
    
    // Set title for the "Next button". Default is "Next".
    keyboardControls.nextTitle = localizedString(@"kNext");
    
    // Add the keyboard control as accessory view for all of the text fields
    // Also set the delegate of all the text fields to self
    for (id textField in keyboardControls.textFields)
    {
        if ([textField isKindOfClass:[UITextField class]])
        {
            ((UITextField *) textField).inputAccessoryView = keyboardControls;
            ((UITextField *) textField).delegate = dg;
        }
        if ([textField isKindOfClass:[UITextView class]])
        {
            ((UITextView *) textField).inputAccessoryView = keyboardControls;
            ((UITextView *) textField).delegate = dg;
        }
    }
    
    return keyboardControls;
}

/*key board animations on scrolling offsets */
+ (void)moveTextFiled:(UITextField *)textField inScrollView:(UIScrollView *)view distance:(CGFloat *)animatedDistance {
    CGRect textFieldRect =
    [view convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [view convertRect:view.bounds fromView:view];
    
    CGFloat midline = textFieldRect.origin.y + textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    /*if (heightFraction < 0.0) //due to content offset goes to negative we dont need this
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }*/
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        *animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        *animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGPoint viewFrame = view.contentOffset;
    viewFrame.y += *animatedDistance;
    
    [view setContentOffset:CGPointMake(view.contentOffset.x, viewFrame.y) animated:YES];
}

+ (void)resetScrollingOffset:(UIScrollView *)view distance:(CGFloat)animatedDistance {
    CGPoint viewFrame = view.contentOffset;
    viewFrame.y -= animatedDistance;
    [view setContentOffset:CGPointMake(view.contentOffset.x, viewFrame.y) animated:YES];
}

+ (void)resetScrollingOffset:(UIScrollView *)view {
    [view setContentOffset:CGPointMake(view.contentOffset.x, 0) animated:YES];
}

+ (void)moveViewWithKeybourd:(UIView *)view distance:(CGFloat *)animatedDistance margin:(NSInteger)bottomMargin {
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        *animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT - bottomMargin);
    }
    else
    {
        *animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT- bottomMargin);
    }
    CGRect viewFrame = view.frame;
    viewFrame.origin.y -= *animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

/* View move animation on window */
+ (void)moveTextFiled:(UITextField *)textField inView:(UIView *)view distance:(CGFloat *)animatedDistance {
    CGRect textFieldRect =
    [view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [view.window convertRect:view.bounds fromView:view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        *animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        *animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = view.frame;
    viewFrame.origin.y -= *animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [view setFrame:viewFrame];
    
    [UIView commitAnimations];
}
/*
 increase y point given distance
 */
+ (void)resetView:(UIView *)view distance:(CGFloat)animatedDistance {
    CGRect viewFrame = view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

/*
 reset origin point
 */
+ (void)resetViewToZeroYCordinate:(UIView *)view
{
    CGRect viewFrame = view.frame;
    viewFrame.origin.y = 0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [view setFrame:viewFrame];
    
    [UIView commitAnimations];
}
/*
 return text size accouring to width/height
 */
+ (CGSize)calculateHeightForText:(NSString *)text font:(UIFont *)font size:(CGSize)size {
    CGSize _size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return _size;
}

@end
