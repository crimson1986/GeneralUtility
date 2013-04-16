//
//  NSObject+Utility.m
//  RegistrationModule
//
//  Created by iPhone Developer on 28/11/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import "NSObject+Utility.h"

@implementation NSObject (Utility)
- (NSArray *)superclasses
{
	Class cl = [self class];
	NSMutableArray *results = [NSMutableArray arrayWithObject:cl];
	
	do 
	{
		cl = [cl superclass];
		[results addObject:cl];
	}
	while (![cl isEqual:[NSObject class]]) ;
	
	return results;
}

+ (BOOL)classExists:(NSString *)className
{
	return (NSClassFromString(className) != nil);
}

+ (id)instanceOfClassNamed:(NSString *)className
{
	if (NSClassFromString(className) != nil)
		return [[NSClassFromString(className) alloc] init];
	else 
		return nil;
}

+ (id)instanceOfNibNamed:(NSString *)NibName {
    if (NSClassFromString(NibName) != nil)
		return [[NSClassFromString(NibName) alloc] initWithNibName:NibName bundle:[NSBundle mainBundle]];
	else 
		return nil;
}

+ (id)loadNibNamed:(NSString *)NibName {
    NSObject *cl = nil;
    if (NSClassFromString(NibName) != nil) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:NibName owner:self options:nil];
        for (id cls in arr) {
            if([cls isKindOfClass:NSClassFromString(NibName)])
            {
                cl = cls;
                break;
            }
        }
    }
    return cl;
}
@end
