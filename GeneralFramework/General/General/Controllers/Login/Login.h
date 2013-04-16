//
//  RMLogin.h
//  RegistrationModule
//
//  Created by Brijesh 04 on 27/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface Login : CustomViewController{
    NSString *tabbarselected;
}
@property (strong, nonatomic) NSString *tabbarselected;


- (void)removeAllKeyboard;
- (IBAction)forgotBtnClick:(id)sender;
@end
