//
//  UIColor+Extends.h
//  BookTrader
//
//  Created by Brijesh 04 on 10/01/13.
//  Copyright (c) 2013 Brijesh 04. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extends)
+ (UIColor *)customOrangeColor;
+ (UIColor *)customLightGrayColor;
+ (UIColor *)customYellowColor;
+ (UIColor *)customTitleValueColor;
+ (UIColor *)customStockBlueColor;
+ (UIColor *)customStockGreenColor;
+ (UIColor *)customStockRedColor;
+ (UIColor *)customInputTextColor;

+ (UIColor *)colorWithRealRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *)colorWithRealRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
@end
