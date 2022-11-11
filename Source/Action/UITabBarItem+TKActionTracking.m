//
//  UITabBarItem+TKActionTracking.m
//  XTracking
//
//  Created by liuxc on 2022/11/10.
//

#import "UITabBarItem+TKActionTracking.h"

#import "TKActionHelper.h"

#import <objc/runtime.h>

@implementation UITabBarItem (TKActionTracking)

#pragma mark - ITKActionObject

- (void)tk_setActionContextWithTrackingId:(NSString *)trackingId userData:(id)userData {
    [TKActionHelper setActionContextToObject:self trackingId:trackingId userData:userData];
}

- (void)tk_clearActionContext {
    [TKActionHelper clearActionContextForObject:self];
}

- (TKActionContext *)tk_actionContext {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTk_actionContext:(TKActionContext *)tk_actionContext {
    objc_setAssociatedObject(self, @selector(tk_actionContext), tk_actionContext, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TKActionContextProvider)tk_actionContextProvider {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTk_actionContextProvider:(TKActionContextProvider)tk_actionContextProvider {
    objc_setAssociatedObject(self, @selector(tk_actionContextProvider), tk_actionContextProvider, OBJC_ASSOCIATION_COPY);
}

@end
