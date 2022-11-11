//
//  AppDelegate.m
//  XTracking
//
//  Created by liuxc on 2022/11/8.
//

#import "AppDelegate.h"
#import "XTracking.h"
#import "ExampleTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ExampleTableViewController *viewController = [[ExampleTableViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    
    [self setupTracking];
    
    return YES;
}

- (void)setupTracking {
    
    // 事件监控
    [[TKActionTracking shared] registActionEventLifeIndicator:self handler:^(id  _Nonnull sender, TKActionContext * _Nonnull action) {
        NSString *trackingId = action.trackingId; //用户声明的trackingId
        id userData = action.userData; //用户声明的业务数据
        NSLog(@"Action Tracking: %@, %@", trackingId, userData);
    }];
    
    // 页面监控
    [[TKPageTracking shared] registPageEventLifeIndicator:self handler:^(TKPageEvent event, TKPageContext * _Nonnull page) {
        NSString *trackingId = page.pageId; //用户声明的trackingId
        id userData = page.userData; //用户声明的业务数据
        NSDate *entryTime = [NSDate dateWithTimeIntervalSince1970:page.pageEntryTime.doubleValue]; //页面进入时间
        NSLog(@"Page Tracking: %@, %@, %@, %@", trackingId, userData, [entryTime description], event == TKPageEventEntry ? @"Entry" : @"Exit");
    }];
    
    // 曝光监控
    [[TKExposeTracking shared] registExposeEventLifeIndicator:self handler:^(UIView * _Nonnull view, TKExposeContext * _Nonnull expose, BOOL isInBackground) {
        NSString *trackingId = expose.trackingId; //用户声明的trackingId
        id userData = expose.userData; //用户声明的业务数据
        NSLog(@"Expose Tracking: %@, %@", trackingId, userData);
    }];
    
    [TKExposeTracking shared].exposeValidDuration = 3000; // 曝光时间3s
    [TKExposeTracking shared].exposeValidSizePercentage = 0.9; // 90%显示
    [[TKExposeTracking shared] startExposeTracking]; // 开启曝光监控
}

@end
