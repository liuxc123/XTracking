

#import "TKPageTracking.h"
#import "UIViewController+TKPageTracking.h"
#import "TKAppLifecycle.h"

@interface TKPageTracking()

@property (nonatomic, strong) NSMapTable<id, TKPageEventHandler> *callbackTable;

@property (nonatomic, strong) NSMutableDictionary<NSString*, TKPageContext*> *classToPageDic;

@property (nonatomic, strong) TKAppLifecycle *appLifecycle;

@end

@implementation TKPageTracking

+ (instancetype)shared {
    static TKPageTracking *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TKPageTracking alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _classToPageDic = [NSMutableDictionary new];
        _callbackTable = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory valueOptions:NSMapTableCopyIn];
        _appLifecycle = [[TKAppLifecycle alloc] init];        
    }
    return self;
}

- (void)registPageContext:(TKPageContext *)pageContext forControllerClass:(Class)controllerClass {
    _classToPageDic[NSStringFromClass(controllerClass)] = pageContext;
}

- (void)registPageContext:(TKPageContext *)pageContext forControllerClassName:(NSString *)controllerClassName {
    _classToPageDic[controllerClassName] = pageContext;
}

- (TKPageContext *)getPageContextFromController:(UIViewController *)controller {
    TKPageContext *page = controller.tk_page;
    if (page != nil) {
        return page;
    }
    page = _classToPageDic[NSStringFromClass(controller.class)];
    if (page != nil) {
        return page;
    }
    return nil;
}

- (void)registPageEventLifeIndicator:(id)lifeIndicator handler:(TKPageEventHandler)handler {
    [_callbackTable setObject:handler forKey:lifeIndicator];
}

- (void)sendAppStart:(TKPageContext *)context {
    NSEnumerator *keyEnum = _callbackTable.keyEnumerator;
    id lifeIndicator;
    while (lifeIndicator = [keyEnum nextObject]) {
        TKPageEventHandler handler = [_callbackTable objectForKey:lifeIndicator];
        if (handler) {
            handler(TKPageEventAppStart, context);
        }
    }
}

- (void)sendAppEnd:(TKPageContext *)context {
    NSEnumerator *keyEnum = _callbackTable.keyEnumerator;
    id lifeIndicator;
    while (lifeIndicator = [keyEnum nextObject]) {
        TKPageEventHandler handler = [_callbackTable objectForKey:lifeIndicator];
        if (handler) {
            handler(TKPageEventAppEnd, context);
        }
    }
}

- (void)sendAppTerminate:(TKPageContext *)context {
    NSEnumerator *keyEnum = _callbackTable.keyEnumerator;
    id lifeIndicator;
    while (lifeIndicator = [keyEnum nextObject]) {
        TKPageEventHandler handler = [_callbackTable objectForKey:lifeIndicator];
        if (handler) {
            handler(TKPageEventAppTerminate, context);
        }
    }
}

- (void)sendPageLoaded:(TKPageContext *)context {
    NSEnumerator *keyEnum = _callbackTable.keyEnumerator;
    id lifeIndicator;
    while (lifeIndicator = [keyEnum nextObject]) {
        TKPageEventHandler handler = [_callbackTable objectForKey:lifeIndicator];
        if (handler) {
            handler(TKPageEventPageLoaded, context);
        }
    }
}

- (void)sendPageEntry:(TKPageContext *)context {
    NSEnumerator *keyEnum = _callbackTable.keyEnumerator;
    id lifeIndicator;
    while (lifeIndicator = [keyEnum nextObject]) {
        TKPageEventHandler handler = [_callbackTable objectForKey:lifeIndicator];
        if (handler) {
            handler(TKPageEventPageEntry, context);
        }
    }
}

- (void)sendPageExit:(TKPageContext *)context {
    NSEnumerator *keyEnum = _callbackTable.keyEnumerator;
    id lifeIndicator;
    while (lifeIndicator = [keyEnum nextObject]) {
        TKPageEventHandler handler = [_callbackTable objectForKey:lifeIndicator];
        if (handler) {
            handler(TKPageEventPageExit, context);
        }
    }
}

- (NSDate *)currentDate {
    if (self.dateHandler) {
        return self.dateHandler();
    }
    return [NSDate date];
}

@end
