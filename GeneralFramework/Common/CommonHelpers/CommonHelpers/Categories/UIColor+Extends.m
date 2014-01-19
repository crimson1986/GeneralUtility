//
//  UIColor+Extends.m
//  BookTrader
//
//  Created by chirag 04 on 10/01/13.
//  Copyright (c) 2013 chirag 04. All rights reserved.
//

#import "UIColor+Extends.h"
#define DEFAULT_VOID_COLOR					[UIColor blackColor]
@implementation UIColor (Extends)
+ (UIColor *)customOrangeColor {
    return [UIColor colorWithRed:255/255.0 green:150/255.0 blue:70/255.0 alpha:1.0];
}

+ (UIColor *)customLightGrayColor {
    return [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
}

+ (UIColor *)customYellowColor {
    return [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
}

+ (UIColor *)customTitleValueColor {
    return [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
}


+ (UIColor *)customStockBlueColor {
    return [UIColor colorWithRed:33/255.0 green:63/255.0 blue:113/255.0 alpha:1.0];
}
+ (UIColor *)customStockGreenColor {
    return [UIColor colorWithRed:92/255.0 green:162/255.0 blue:1/255.0 alpha:1.0];
}
+ (UIColor *)customStockRedColor {
    return [UIColor colorWithRed:233/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
}
+ (UIColor *)customInputTextColor {
    return [UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:1.0];
}
+ (CGFloat)getFrom:(CGFloat)value {
	//NSLog(@"From value:%f to: %f", value, (value / 255));
	return (value / 255.f);
}

+ (UIColor *)colorWithRealRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	return [UIColor colorWithRed:[self getFrom:red] green:[self getFrom:green] blue:[self getFrom:blue] alpha:alpha];
}

- (UIColor *)colorWithRealRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	return [UIColor colorWithRed:[UIColor getFrom:red] green:[UIColor getFrom:green] blue:[UIColor getFrom:blue] alpha:alpha];
}

+ (UIColor *)randomColor {
	CGFloat red =  (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha {
	CGFloat red =  (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithHexString: (NSString *)stringToConvert{
	NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return DEFAULT_VOID_COLOR;
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	
	if ([cString length] != 6) return DEFAULT_VOID_COLOR;
	
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:1.0f];
}
@end
