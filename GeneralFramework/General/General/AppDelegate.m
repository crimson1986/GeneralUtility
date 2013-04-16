//
//  AppDelegate.m
//  General
//
//  Created by Brijesh 04 on 26/02/13.
//  Copyright (c) 2013 Brijesh 04. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomSplash.h"
#import "Reachability.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "MoreViewController.h"
#import "Login.h"

NSString * const kTabbarNotification = @"kTabbarNotification";
NSString * const kHomeNotification = @"kHomeNotification";

@interface AppDelegate () <BCSplashDelegate>
@property (strong, nonatomic) Reachability* hostReach;
@property (strong, nonatomic) Reachability* internetReach;
@property (strong, nonatomic) Reachability* wifiReach;
@end

@implementation AppDelegate

#pragma mark --

+ (AppDelegate *)sharedInstance {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark --
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addTabbarController:) name:kTabbarNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addHomeController:) name:kHomeNotification object:nil];
    if(isIphone5()){
        self.viewController = [[CustomSplash alloc] initWithImageName:@"Default-568h@2x"];
    } else {
        self.viewController = [[CustomSplash alloc] initWithImageName:@"Default"];
    }
    self.viewController.delegate = self;
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.navController.navigationBarHidden = YES;
    
    [self.window addSubview:self.navController.view];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    self.tabBarController = nil;
    self.navController = nil;
}

#pragma mark - Tabbar initialize
-(void)setupTabBarController
{
    self.tabBarController = [[CustomTabBarController alloc] init];
    NSMutableArray* viewControllers = [[NSMutableArray alloc] init];
    
    
    OneViewController *ProductsViewController = [OneViewController instanceOfNibNamed:@"OneViewController"];
    UINavigationController *ProductsNavigationController = [[UINavigationController alloc] initWithRootViewController:ProductsViewController];
    ProductsNavigationController.navigationBarHidden = YES;
    UITabBarItem* tabBarItem = [[UITabBarItem alloc] init];
    [tabBarItem  setFinishedSelectedImage: [UIImage imageNamed:@"tab1"]
              withFinishedUnselectedImage: [UIImage imageNamed: @"tab1"]];
    [ProductsNavigationController setTabBarItem: tabBarItem];
    [viewControllers addObject:ProductsNavigationController];
    
    TwoViewController *MarketViewController = [TwoViewController instanceOfNibNamed:@"TwoViewController"];
    UINavigationController *MarketNavigationController = [[UINavigationController alloc] initWithRootViewController:MarketViewController];
    MarketNavigationController.navigationBarHidden = YES;
    UITabBarItem* savedTabBarItem = [[UITabBarItem alloc] init];
    [savedTabBarItem  setFinishedSelectedImage: [UIImage imageNamed:@"tab2"]
                   withFinishedUnselectedImage: [UIImage imageNamed: @"tab2"]];
    [MarketNavigationController setTabBarItem: savedTabBarItem];
    [viewControllers addObject:MarketNavigationController];
    
    ThreeViewController *SpecialsViewController = [ThreeViewController instanceOfNibNamed:@"ThreeViewController"];
    UINavigationController *SpecialNavigationController = [[UINavigationController alloc] initWithRootViewController:SpecialsViewController];
    SpecialNavigationController.navigationBarHidden = YES;
    UITabBarItem* searchTabBarItem = [[UITabBarItem alloc] init];
    [searchTabBarItem  setFinishedSelectedImage: [UIImage imageNamed:@"tab3"]
                    withFinishedUnselectedImage: [UIImage imageNamed: @"tab3"]];
    [SpecialNavigationController setTabBarItem: searchTabBarItem];
    [viewControllers addObject:SpecialNavigationController];
    
    FourViewController *NewsViewController = [FourViewController instanceOfNibNamed:@"FourViewController"];
    UINavigationController *NewsNavigationController = [[UINavigationController alloc] initWithRootViewController:NewsViewController];
    NewsNavigationController.navigationBarHidden = YES;
    UITabBarItem* recentTabBarItem = [[UITabBarItem alloc] init];
    [recentTabBarItem  setFinishedSelectedImage: [UIImage imageNamed:@"tab4"]
                    withFinishedUnselectedImage: [UIImage imageNamed: @"tab4"]];
    [NewsNavigationController setTabBarItem: recentTabBarItem];
    [viewControllers addObject:NewsNavigationController];
    
    MoreViewController *ContactViewController = [MoreViewController instanceOfNibNamed:@"MoreViewController"];
    UINavigationController *ContactNavigationController = [[UINavigationController alloc] initWithRootViewController:ContactViewController];
    ContactNavigationController.navigationBarHidden = YES;
    UITabBarItem* accountTabBarItem = [[UITabBarItem alloc] init];
    [accountTabBarItem  setFinishedSelectedImage: [UIImage imageNamed:@"tab5"]
                     withFinishedUnselectedImage: [UIImage imageNamed: @"tab5"]];
    [ContactNavigationController setTabBarItem: accountTabBarItem];
    [viewControllers addObject:ContactNavigationController];
    

    
    
	self.tabBarController.delegate = self;
	self.tabBarController.viewControllers = viewControllers;
    
    [self.navController popToRootViewControllerAnimated:NO];
    [self.navController.view removeFromSuperview];
    
    [UIView beginAnimations:@"animation" context:nil];
    [self.window addSubview:[self.tabBarController view]];
    [self.tabBarController.view setBackgroundColor:[UIColor clearColor]];
    
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window  cache:NO];
    [UIView commitAnimations];
}
#pragma mark Notifications
- (void)addTabbarController:(NSNotification *)noti {
    [self setupTabBarController];
}
- (void)addHomeController:(NSNotification *)noti {

    [self.tabBarController.view removeFromSuperview];
    [UIView beginAnimations:@"animation" context:nil];
    Login *login = [Login instanceOfNibNamed:@"Login"];
    [self.navController setViewControllers:[NSArray arrayWithObject:login]];
    [self.window addSubview:self.navController.view];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navController.view cache:NO];
    [UIView commitAnimations];
}

#pragma mark Splash Delegate
- (void)progressDidFinished {
    self.viewController.delegate = nil;
    [self.viewController.view removeFromSuperview];
    self.viewController = nil;
//    [self setupTabBarController];
    [[NSNotificationCenter defaultCenter] postNotificationName:kHomeNotification object:nil];
}

@end
