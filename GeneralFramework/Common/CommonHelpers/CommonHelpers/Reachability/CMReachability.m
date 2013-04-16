//
//  CMReachability.m
//  General
//
//  Created by Brijesh 04 on 01/03/13.
//  Copyright (c) 2013 Brijesh 04. All rights reserved.
//



#import "CMReachability.h"
#import "Reachability.h"

@interface CMReachability ()
@property (strong, nonatomic) Reachability* hostReach;
@property (strong, nonatomic) Reachability* internetReach;
@property (strong, nonatomic) Reachability* wifiReach;
@property (copy, nonatomic) CMReachabilityCallback callBack;
@end

@implementation CMReachability

#pragma mark Reachability
- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    BOOL connectionRequired= [curReach connectionRequired];
    NSString* statusString= @"";
    switch (netStatus)
    {
        case NotReachable:
        {
            statusString = @"Access Not Available";
            //Minor interface detail- connectionRequired may return yes, even when the host is unreachable.  We cover that up here...
            connectionRequired= YES;
            break;
        }
            
        case ReachableViaWWAN:
        {
            statusString = @"Reachable WWAN";
            connectionRequired= NO;
            break;
        }
        case ReachableViaWiFi:
        {
            statusString= @"Reachable WiFi";
            connectionRequired= NO;
            break;
        }
    }
    if(connectionRequired)
    {
        statusString= [NSString stringWithFormat: @"%@, Connection Required", statusString];
//        [[BCAppShared sharedInstance] showHintWithText:statusString inWindow:self.window];
        self.callBack (statusString);
    }
    
	
}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability: curReach];
}
- (void)registerReachabilityWithCallBack:(CMReachabilityCallback)callBk {

    self.callBack = callBk;
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    //Change the host name here to change the server your monitoring
    
	self.hostReach = [Reachability reachabilityWithHostName: @"www.apple.com"];
	[self.hostReach startNotifier];
    //	[self updateInterfaceWithReachability: self.hostReach];
	
    self.internetReach = [Reachability reachabilityForInternetConnection];
	[self.internetReach startNotifier];
    //	[self updateInterfaceWithReachability: self.internetReach];
    
    self.wifiReach = [Reachability reachabilityForLocalWiFi];
	[self.wifiReach startNotifier];
    //	[self updateInterfaceWithReachability: self.wifiReach];
}

- (void)removeReachability {
    [[NSNotificationCenter defaultCenter] postNotificationName:kReachabilityChangedNotification object:nil];
    self.hostReach = nil;
    self.internetReach = nil;
    self.wifiReach = nil;
}
@end
