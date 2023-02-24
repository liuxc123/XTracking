//
//  TKAppLifecycle.h
//  XTracking
//
//  Created by liuxc on 2023/2/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// SDK 生命周期状态
typedef NS_ENUM(NSUInteger, TKAppLifecycleState) {
    TKAppLifecycleStateInit = 1,
    TKAppLifecycleStateStart,
    TKAppLifecycleStateStartPassively,
    TKAppLifecycleStateEnd,
    TKAppLifecycleStateTerminate,
};

/// 当生命周期状态即将改变时，会发送这个通知
/// object：对象为当前的生命周期对象
/// userInfo：包含 kTKAppLifecycleNewStateKey 和 kTKAppLifecycleOldStateKey 两个 key，分别对应状态改变的前后状态
extern NSNotificationName const kTKAppLifecycleStateWillChangeNotification;
/// 当生命周期状态改变后，会发送这个通知
/// object：对象为当前的生命周期对象
/// userInfo：包含 kTKAppLifecycleNewStateKey 和 kTKAppLifecycleOldStateKey 两个 key，分别对应状态改变的前后状态
extern NSNotificationName const kTKAppLifecycleStateDidChangeNotification;
/// 在状态改变通知回调中，获取新状态
extern NSString * const kTKAppLifecycleNewStateKey;
/// 在状态改变通知回调中，获取之前的状态
extern NSString * const kTKAppLifecycleOldStateKey;

@interface TKAppLifecycle : NSObject

@property (nonatomic, assign, readonly) TKAppLifecycleState state;

@end

NS_ASSUME_NONNULL_END
