//
//  RMButton.h
//  RegistrationModule
//
//  Created by iPhone Developer on 30/11/12.
//  Copyright (c) 2012 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CustomButtonDelegate;
@interface CustomButton : UIButton
{
    __unsafe_unretained id<CustomButtonDelegate> _buttonDelegate;
}
@property (unsafe_unretained) id<CustomButtonDelegate> buttonDelegate;
@end

@protocol CustomButtonDelegate <NSObject>

- (void)action:(NSInteger)type;

@end