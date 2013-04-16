//
//  RMSplash.h
//  RegistrationModule
//
//  Created by Brijesh 04 on 27/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BCSplashDelegate;
@interface CustomSplash : UIViewController
{
//    id<RMSplashDelegate> delegate;
}
@property (nonatomic, unsafe_unretained)id<BCSplashDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *imgSplash;
- (id)initWithImageName:(NSString *)_imageName;
@end

@protocol BCSplashDelegate <NSObject>

- (void)progressDidFinished;

@end