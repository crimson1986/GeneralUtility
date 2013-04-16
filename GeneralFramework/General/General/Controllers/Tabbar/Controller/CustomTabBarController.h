#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@protocol CustomTabBarControllerDelegate;

@interface CustomTabBarController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, strong)   NSArray             *viewControllers;
@property (nonatomic, strong)   UIViewController    *selectedViewController;
@property (nonatomic, strong)   id                  <CustomTabBarControllerDelegate> delegate;
@property (nonatomic, strong)   UIFont              *font;
@property (nonatomic, assign)   CGSize              maxItemSize;
@property (nonatomic, unsafe_unretained)   NSArray             *items;
@property (nonatomic, strong)   NSMutableArray      *itemViews;
@property (nonatomic, strong)   UIView              *tabButtonsContainerView;
@property (nonatomic, strong)   UIView              *contentContainerView;
@property (nonatomic, strong)   UIView              *shadowView;
@property (nonatomic, strong)   UIImageView         *moreItemView;
@property (nonatomic, assign)   NSUInteger          itemsPerRow;
@property (nonatomic, readonly) NSUInteger          rows;
@property (nonatomic, assign)   NSUInteger          selectedIndex;
@property (nonatomic, assign)   BOOL                moreButtonPressed;
@property (nonatomic, strong)   UIViewController    *fromController;
@property (nonatomic, strong)   UIViewController    *toController;
@property (nonatomic, strong)   NSMutableArray      *tabBarItems;
@property (nonatomic, strong)   UIGestureRecognizer *tapGesture;

- (void)hideTabBar;
- (void)showTabBar;
- (void)setSelectedIndex:(NSUInteger)newSelectedIndex animated:(BOOL)animated;
@end

/*!
 * The delegate protocol for CRTabBarController.
 */
@protocol CustomTabBarControllerDelegate <NSObject>
@optional
- (BOOL)cr_tabBarController:(CustomTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
- (void)cr_tabBarController:(CustomTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
@end
