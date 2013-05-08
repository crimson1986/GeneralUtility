
#import <UIKit/UIKit.h>
#import "CustomTabBarController.h"

extern NSString * const kTabbarNotification;
extern NSString * const kHomeNotification;

@class CustomSplash;
@interface AppDelegate : UIResponder <UIApplicationDelegate,CustomTabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) CustomSplash *viewController;
@property (strong,nonatomic) CustomTabBarController *tabBarController;
+ (AppDelegate *)sharedInstance;
@end
