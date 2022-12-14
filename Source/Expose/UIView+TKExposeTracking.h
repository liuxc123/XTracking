//
//  UIView+TKExposeTracking.h
//  XTracking
//
//  Created by liuxc on 2022/11/10.
//

#import <UIKit/UIKit.h>
#import "TKExposeContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TKExposeTracking)

/// 当对同一个view设置新的曝光数据时（比如对可重用的cell设置新的曝光数据），一定要整体对tk_exposeContext赋值，而不是更改view.tk_exposeContext的某个属性
/// 如果只是更改cell.tk_exposeContext的属性，当两次屏幕刷新间隔内一个cell从一个显示位置移动到另一个显示位置，框架会认为这个cell一直在连续的曝光中，不会发送新的曝光打点
@property (nonatomic, strong) TKExposeContext *_Nullable tk_exposeContext;

/// 设置曝光数据快捷方法
- (void)tk_setExposeContextWithTrackingId:(NSString * _Nullable)trackingId
                                 userData:(id _Nullable)userData;

/// 清空曝光数据快捷方法
- (void)tk_clearExposeContext;

#pragma mark - Private 上层应用业务不要使用

/// 当前view是否在屏幕上有效可见（显示且显示面积/view面积 > 最小显示比例）
@property (nonatomic, assign, readonly) BOOL tk_isValidVisible;

/// 设置view延时曝光
- (void)tk_setupExposeDelay:(NSTimeInterval)duration completeBlock:(nullable void (^)(void))completeBlock;

@end

NS_ASSUME_NONNULL_END
