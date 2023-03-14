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
    
    /// 自定义时间  用于获取服务器时间
    [TKPageTracking shared].dateHandler = ^NSDate * _Nullable{
        return [NSDate date];
    };
    
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
        
        NSLog(@"------------------------------------------------------");
        NSLog(@"Page Tracking: %@, %@, %u", trackingId, userData, event);
        NSLog(@"页面监控---进入页面时间戳：%d, 退出页面时间戳: %d，进入前台时间戳：%d, 进入后台时间戳：%d, 页面在后台时长：%d, 页面浏览总时长：%d", page.pageEntryTimeStamp.intValue, page.pageExitTimeStamp.intValue, page.appStartTimeStamp.intValue, page.appEndTimeStamp.intValue, page.appEndDuration.intValue, page.pageBrowseDuration.intValue);
        NSLog(@"******************************************************");
    }];
    
    // 曝光监控
    [[TKExposeTracking shared] registExposeEventLifeIndicator:self handler:^(UIView * _Nonnull view, TKExposeContext * _Nonnull expose, BOOL isInBackground) {
        NSString *trackingId = expose.trackingId; //用户声明的trackingId
        id userData = expose.userData; //用户声明的业务数据
        NSLog(@"Expose Tracking: %@, %@", trackingId, userData);
    }];
    
    [[TKExposeTracking shared] startExposeTracking]; // 开启曝光监控
}

@end
