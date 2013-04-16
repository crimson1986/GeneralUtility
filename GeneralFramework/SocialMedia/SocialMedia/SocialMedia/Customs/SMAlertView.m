//
//  SMAlertView.m
//  SocialMedia
//
//  Created by Brijesh 04 on 25/02/13.
//  Copyright (c) 2013 Brijesh 04. All rights reserved.
//

/*
 NSMutableString *otherTitle = [NSMutableString new];
 id eachObject = nil;
 va_list argumentList = nil;
 if (otherButtonTitles   )
 {
 // do something with firstObject. Remember, it is not part of the variable argument list
 [otherTitle appendString:otherButtonTitles];
 va_start(argumentList, otherButtonTitles);          // scan for arguments after firstObject.
 while ((eachObject = va_arg(argumentList, id))) // get rest of the objects until nil is found
 {
 // do something with each object
 if ([eachObject isKindOfClass:[NSString class]]) {
 [otherTitle appendString:eachObject];
 }
 
 }
 va_end(argumentList);
 }
 */

#import "SMAlertView.h"

@implementation SMAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{

    NSString *str = nil;
    va_list args;
    va_start(args, otherButtonTitles);
    str = [[NSString alloc] initWithFormat:otherButtonTitles arguments:args];
    va_end(args);
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:str,nil];

    return self;
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(SMAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(_completionHandler)
        self.completionHandler(alertView,buttonIndex);
}

@end
