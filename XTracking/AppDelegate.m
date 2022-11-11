//
//  AppDelegate.m
//  XTracking
//
//  Created by liuxc on 2022/11/8.
//

#import "AppDelegate.h"
#import "XTracking.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[TKActionTracking shared] registActionEventLifeIndicator:self handler:^(id  _Nonnull sender, TKActionContext * _Nonnull action) {
        NSString *trackingId = action.trackingId; //用户声明的trackingId
        id userData = action.userData; //用户声明的业务数据
        NSLog(@"Action Tracking: %@, %@", trackingId, userData);
    }];
    
    [[TKExposeTracking shared] registExposeEventLifeIndicator:self handler:^(UIView * _Nonnull view, TKExposeContext * _Nonnull expose, BOOL isInBackground) {
        NSString *trackingId = expose.trackingId; //用户声明的trackingId
        id userData = expose.userData; //用户声明的业务数据
        NSLog(@"Expose Tracking: %@, %@", trackingId, userData);
    }];
    
    [[TKExposeTracking shared] startExposeTracking];
    
    [[TKPageTracking shared] registPageEventLifeIndicator:self handler:^(TKPageEvent event, TKPageContext * _Nonnull page) {
        NSString *trackingId = page.pageId; //用户声明的trackingId
        id userData = page.userData; //用户声明的业务数据
        NSDate *entryTime = [NSDate dateWithTimeIntervalSince1970:page.pageEntryTime.doubleValue]; //页面进入时间
        NSLog(@"Page Tracking: %@, %@, %@, %@", trackingId, userData, [entryTime description], event == TKPageEventEntry ? @"Entry" : @"Exit");
    }];
    
    return YES;
}

@end
