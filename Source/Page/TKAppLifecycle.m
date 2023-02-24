//
//  TKAppLifecycle.m
//  XTracking
//
//  Created by liuxc on 2023/2/24.
//

#import "TKAppLifecycle.h"
#import <UIKit/UIKit.h>

NSNotificationName const kTKAppLifecycleStateWillChangeNotification = @"com.xtracking.TKAppLifecycleStateWillChange";
NSNotificationName const kTKAppLifecycleStateDidChangeNotification = @"com.xtracking.TKAppLifecycleStateDidChange";
NSString * const kTKAppLifecycleNewStateKey = @"new";
NSString * const kTKAppLifecycleOldStateKey = @"old";

@interface TKAppLifecycle ()

@property (nonatomic, assign) TKAppLifecycleState state;

@end

@implementation TKAppLifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _state = TKAppLifecycleStateInit;

        [self setupListeners];
        [self setupLaunchedState];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupLaunchedState {
    if ([TKAppLifecycle isAppExtension]) {
        return;
    }
    dispatch_block_t mainThreadBlock = ^(){
        UIApplication *application = [UIApplication sharedApplication];
        BOOL isAppStateBackground = application.applicationState == UIApplicationStateBackground;
        self.state = isAppStateBackground ? TKAppLifecycleStateStartPassively : TKAppLifecycleStateStart;
    };

    if (@available(iOS 13.0, *)) {
        // iOS 13 及以上在异步主队列的 block 修改状态的原因:
        // 1. 保证在执行启动（被动启动）事件时（动态）公共属性设置完毕（通过监听 UIApplicationDidFinishLaunchingNotification 可以实现）
        // 2. 含有 SceneDelegate 的工程中延迟获取 applicationState 才是准确的（通过监听 UIApplicationDidFinishLaunchingNotification 获取不准确）
        dispatch_async(dispatch_get_main_queue(), mainThreadBlock);
    } else {
        // iOS 13 以下通过监听 UIApplicationDidFinishLaunchingNotification 的通知来处理被动启动和冷启动（非延迟初始化）的情况:
        // 1. iOS 13 以下被动启动时异步主队列的 block 不会执行
        // 2. iOS 13 以下不会含有 SceneDelegate
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];
        // 处理 iOS 13 以下（冷启动）延迟初始化的情况
        dispatch_async(dispatch_get_main_queue(), mainThreadBlock);
    }
}

#pragma mark - Setter

- (void)setState:(TKAppLifecycleState)state {
    if (_state == state) {
        return;
    }

    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    userInfo[kTKAppLifecycleNewStateKey] = @(state);
    userInfo[kTKAppLifecycleOldStateKey] = @(_state);

    [[NSNotificationCenter defaultCenter] postNotificationName:kTKAppLifecycleStateWillChangeNotification object:self userInfo:userInfo];

    _state = state;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kTKAppLifecycleStateDidChangeNotification object:self userInfo:userInfo];
}

#pragma mark - Listener

- (void)setupListeners {
    // app extension does not need state observer
    if ([TKAppLifecycle isAppExtension]) {
        return;
    }

    // 监听 App 启动或结束事件
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(applicationDidBecomeActive:)
                               name:UIApplicationDidBecomeActiveNotification
                             object:nil];

    [notificationCenter addObserver:self
                           selector:@selector(applicationDidEnterBackground:)
                               name:UIApplicationDidEnterBackgroundNotification
                             object:nil];

    [notificationCenter addObserver:self
                           selector:@selector(applicationWillTerminate:)
                               name:UIApplicationWillTerminateNotification
                        object:nil];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSLog(@"application did finish launching");

    UIApplication *application = [UIApplication sharedApplication];
    BOOL isAppStateBackground = application.applicationState == UIApplicationStateBackground;
    self.state = isAppStateBackground ? TKAppLifecycleStateStartPassively : TKAppLifecycleStateStart;
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    NSLog(@"application did become active");

    // 防止主动触发 UIApplicationDidBecomeActiveNotification
    if (![notification.object isKindOfClass:[UIApplication class]]) {
        return;
    }

    UIApplication *application = (UIApplication *)notification.object;
    if (application.applicationState != UIApplicationStateActive) {
        return;
    }

    self.state = TKAppLifecycleStateStart;
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    NSLog(@"application did enter background");

    // 防止主动触发 UIApplicationDidEnterBackgroundNotification
    if (![notification.object isKindOfClass:[UIApplication class]]) {
        return;
    }

    UIApplication *application = (UIApplication *)notification.object;
    if (application.applicationState != UIApplicationStateBackground) {
        return;
    }

    self.state = TKAppLifecycleStateEnd;
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    NSLog(@"application will terminate");

    self.state = TKAppLifecycleStateTerminate;
}

+ (BOOL)isAppExtension {
    NSString *bundlePath = [[NSBundle mainBundle] executablePath];
    if (!bundlePath) {
        return NO;
    }

    return [bundlePath containsString:@".appex/"];
}

@end
