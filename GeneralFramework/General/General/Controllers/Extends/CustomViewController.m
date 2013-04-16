//
//  MTCustomViewController.m
//  Merit
//
//  Created by Brijesh 04 on 04/02/13.
//  Copyright (c) 2013 Brijesh 04. All rights reserved.
//

#import "CustomViewController.h"


@interface CustomViewController ()

@end

@implementation CustomViewController

- (HeaderView *)topNavigationBar {
    if (!_topNavigationBar) {
        _topNavigationBar = [HeaderView loadNibNamed:@"HeaderView"];
      //  [_topNavigationBar setTitle:@"Merit"];
#ifdef SLIDER
        _topNavigationBar.leftMenuButton.hidden = NO;
#else
        _topNavigationBar.leftMenuButton.hidden = YES;
#endif
        _topNavigationBar.btnBack.hidden = YES;
        [_topNavigationBar.btnBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//        [_topNavigationBar.btnCall addTarget:self action:@selector(goCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topNavigationBar;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.trackedViewName = @"Navigation Controller";
	// Do any additional setup after loading the view.
    [self.view addSubview:self.topNavigationBar];
    [self.view sendSubviewToBack:self.topNavigationBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Only rotate if all child view controllers agree on the new orientation.
    return YES;
}
#pragma -
#pragma mark Custom Methods

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)goCall{
//    [[BCAppShared sharedInstance]makeCallOnNumber:@"123456789"];
}
@end
