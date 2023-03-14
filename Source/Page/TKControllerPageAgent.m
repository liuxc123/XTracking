

#import "TKControllerPageAgent.h"
#import "TKPageTracking.h"
#import "ITKPageObject.h"

@interface TKControllerPageAgent()

@property (nonatomic, strong) NSMutableArray<TKPageContext*> *pageStack;
@property (nonatomic, assign) BOOL isLoaded;
@property (nonatomic, assign) BOOL hasDisappeared;
@property (nonatomic, weak) UIViewController *bindedController;

@end

@implementation TKControllerPageAgent

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageStack = [NSMutableArray new];
    }
    return self;
}

- (void)bindToControllerIfNeed:(UIViewController*)controller {
    if (self.mode != TKControllerPageModeBindToController) {
        return;
    }
    if (self.topPage != nil) {
        //已经绑定过了
        return;
    }
    TKPageContext *page = [TKPageTracking.shared getPageContextFromController:controller];
    if (page == nil) {
        //用户不需要对该controller进行跟踪
        return;
    }
    self.bindedController = controller;
    [_pageStack removeAllObjects];
    [_pageStack addObject:page];
}

- (void)push:(TKPageContext*)pageContext {
    TKPageContext *last = _pageStack.lastObject;
    if (last) {
        [self sendPageExit:last];
        if (self.mode != TKControllerPageModePushPop) {
            [_pageStack removeAllObjects];
        }
    }
    [self sendPageEntry:pageContext];
    [_pageStack addObject:pageContext];
}

- (void)pop {
    TKPageContext *page = self.topPage;
    if (page) {
        [self sendPageExit:page];
        [_pageStack removeObject:page];
    }
    page = self.topPage;
    if (page) {
        [self sendPageEntry:page];
    }
}

- (void)loaded {
    if (_isLoaded) return;
    _isLoaded = true;
    TKPageContext *page = self.topPage;
    if (page) {
        [self sendPageLoaded:page];
    }
}

- (void)appear {
    if (self.mode != TKControllerPageModeBindToController && !_hasDisappeared) {
        //防止第一次appear和push重复发送entry事件
        return;
    }
    TKPageContext *page = self.topPage;
    if (page) {
        [self sendPageEntry:page];
    }
}

- (void)disappear {
    _hasDisappeared = true;
    TKPageContext *page = self.topPage;
    if (page) {
        [self sendPageExit:page];
    }
}

- (void)appStart {
    TKPageContext *page = self.topPage;
    if (page) {
        [self sendAppStart:page];
    }
}

- (void)appEnd {
    TKPageContext *page = self.topPage;
    if (page) {
        [self sendAppEnd:page];
    }
}

- (void)appTerminate {
    TKPageContext *page = self.topPage;
    if (page) {
        [self sendAppTerminate:page];
    }
}

- (TKPageContext *)topPage {
    if (_pageStack.count == 0) {
        return nil;
    }
    return _pageStack.lastObject;
}

- (void)sendAppStart:(TKPageContext *)page {
    [page updateAppStartTimeStamp];
    [page updateAppEndDuration];
    [[TKPageTracking shared] sendAppStart:page];
    if ([self.bindedController conformsToProtocol:@protocol(ITKPageObject)]) {
        id<ITKPageObject> obj = (id<ITKPageObject>)self.bindedController;
        if ([obj respondsToSelector:@selector(appStart:)]) {
            [obj appStart:page];
        }
    }
}

- (void)sendAppEnd:(TKPageContext *)page {
    [page updateAppEndTimeStamp];
    [page updatePageBrowseDuration];
    [[TKPageTracking shared] sendAppEnd:page];
    if ([self.bindedController conformsToProtocol:@protocol(ITKPageObject)]) {
        id<ITKPageObject> obj = (id<ITKPageObject>)self.bindedController;
        if ([obj respondsToSelector:@selector(appEnd:)]) {
            [obj appEnd:page];
        }
    }
}

- (void)sendAppTerminate:(TKPageContext *)page {
    [page updateAppEndTimeStamp];
    [page updatePageBrowseDuration];
    [[TKPageTracking shared] sendAppTerminate:page];
    if ([self.bindedController conformsToProtocol:@protocol(ITKPageObject)]) {
        id<ITKPageObject> obj = (id<ITKPageObject>)self.bindedController;
        if ([obj respondsToSelector:@selector(appTerminate:)]) {
            [obj appTerminate:page];
        }
    }
}

- (void)sendPageLoaded:(TKPageContext *)page {
    [[TKPageTracking shared] sendPageLoaded:page];
    if ([self.bindedController conformsToProtocol:@protocol(ITKPageObject)]) {
        id<ITKPageObject> obj = (id<ITKPageObject>)self.bindedController;
        if ([obj respondsToSelector:@selector(pageLoaded:)]) {
            [obj pageLoaded:page];
        }
    }
}

- (void)sendPageEntry:(TKPageContext *)page {
    [page updatePageEntryTimeStamp];
    [[TKPageTracking shared] sendPageEntry:page];
    if ([self.bindedController conformsToProtocol:@protocol(ITKPageObject)]) {
        id<ITKPageObject> obj = (id<ITKPageObject>)self.bindedController;
        if ([obj respondsToSelector:@selector(pageEntry:)]) {
            [obj pageEntry:page];
        }
    }
}

- (void)sendPageExit:(TKPageContext *)page {
    [page updatePageExitTimeStamp];
    [page updatePageBrowseDuration];
    [[TKPageTracking shared] sendPageExit:page];
    if ([self.bindedController conformsToProtocol:@protocol(ITKPageObject)]) {
        id<ITKPageObject> obj = (id<ITKPageObject>)self.bindedController;
        if ([obj respondsToSelector:@selector(pageExit:)]) {
            [obj pageExit:page];
        }
    }
}

@end
