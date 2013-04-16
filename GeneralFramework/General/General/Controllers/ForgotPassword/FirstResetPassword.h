//
//  FirstResetPassword.h
//  Beachory
//
//  Created by Brijesh 01 on 1/25/13.
//  Copyright (c) 2013 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FirstResetPasswordDelegate;
@interface FirstResetPassword : CustomViewController{
    id<FirstResetPasswordDelegate> _delegateresPass;
    
  }
@property (nonatomic)id<FirstResetPasswordDelegate> delegateresPass;
-(IBAction)btnSave:(id)sender;

- (void)startBounce;
@end


@protocol FirstResetPasswordDelegate <NSObject>

- (void)SaveClicked;

@end
