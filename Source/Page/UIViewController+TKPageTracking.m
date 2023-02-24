#import "UIViewController+TKPageTracking.h"
#import "TKClassHooker.h"
#import <objc/runtime.h>

static const void *tk_modalParentControllerKey;

@implementation UIViewController (TKPageTracking)

+ (void)load {
    static dispatch_once_t once_token;
    dispatch_once(&once_token,  ^{
        [TKClassHooker exchangeOriginMethod:@selector(viewDidAppear:)
                                  newMethod:@selector(tk_viewDidAppear:)
                                     mclass:[UIViewController class]];
        
        [TKClassHooker exchangeOriginMethod:@selector(viewDidDisappear:)
                                  newMethod:@selector(tk_viewDidDisappear:)
                                     mclass:[UIViewController class]];

        [TKClassHooker exchangeOriginMethod:@selector(presentViewController:animated:completion:)
                                  newMethod:@selector(tk_presentViewController:animated:completion:)
                                     mclass:[UIViewController class]];

        [TKClassHooker exchangeOriginMethod:@selector(dismissViewControllerAnimated:completion:)
                                  newMethod:@selector(tk_dismissViewControllerAnimated:completion:)
                                     mclass:[UIViewController class]];
    });
}

- (void)tk_viewDidAppear:(BOOL)animated {
    if (self.tk_pageAgent.mode == TKControllerPageModeBindToController) {
        [self.tk_pageAgent bindToControllerIfNeed:self];
    }
    [self.tk_pageAgent appear];
    [self tk_viewDidAppear:animated];
}

- (void)tk_viewDidDisappear:(BOOL)animated {
    [self.tk_pageAgent disappear];
    [self tk_viewDidDisappear:animated];
}

- (TKPageContext *)tk_page {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTk_page:(TKPageContext *)tk_page {
    objc_setAssociatedObject(self, @selector(tk_page), tk_page, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TKControllerPageAgent *)tk_pageAgent {
    TKControllerPageAgent *agent = objc_getAssociatedObject(self, _cmd);
    if (agent == nil) {
        agent = [TKControllerPageAgent new];
        objc_setAssociatedObject(self, _cmd, agent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return agent;
}


- (void)tk_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [self tk_presentViewController:viewControllerToPresent animated:flag completion:completion];
    if ([viewControllerToPresent isMemberOfClass:NSClassFromString(@"UdeskBaseNavigationViewController")]) {
        [self.tk_pageAgent disappear];
        if ([viewControllerToPresent isKindOfClass:[UINavigationController class]]) {
            UIViewController *vc = ((UINavigationController *)viewControllerToPresent).childViewControllers.lastObject;
            vc.tk_modalParentController = self;
        } else {
            viewControllerToPresent.tk_modalParentController = self;
        }
    }
}

- (void)tk_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [self tk_dismissViewControllerAnimated:flag completion:completion];
    if (self.tk_modalParentController) {
        [self.tk_modalParentController.tk_pageAgent appear];
    }
}

- (UIViewController *)tk_modalParentController {
    return objc_getAssociatedObject(self, &tk_modalParentControllerKey);
}

- (void)setTk_modalParentController:(UIViewController *)tk_modalParentController {
    objc_setAssociatedObject(self, &tk_modalParentControllerKey, tk_modalParentController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
