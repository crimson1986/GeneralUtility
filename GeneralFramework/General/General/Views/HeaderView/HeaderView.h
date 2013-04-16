//
//  BTHeader.h
//  BookTrader
//
//  Created by Brijesh 04 on 08/01/13.
//  Copyright (c) 2013 Brijesh 04. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HeaderView : UIView
@property (strong, nonatomic) IBOutlet UIView *viewNavigation;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UILabel  *lblBookbackTitle;
//@property (strong, nonatomic) IBOutlet UIButton *btnCall;

@property (strong, nonatomic) IBOutlet UIImageView *imgBackground;
@property (strong, nonatomic) IBOutlet CustomLabel *lblHeadingTitle;
@property (strong, nonatomic) IBOutlet UIButton *leftMenuButton;
- (void)setBackButtonHide:(BOOL)hide;
- (void)setBackBookButtonHide:(BOOL)hide bookText:(NSString *)bookText;
- (IBAction)showLeftMenu:(id)sender;
- (void)setTitle:(NSString *)text;
-(void)showSettingAndRemoveButton;
@end
