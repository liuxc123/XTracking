#import <UIKit/UIKit.h>
#import "TKPageContext.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum TKPageEvent {
    TKPageEventLoaded = 0,
    TKPageEventEntry = 1,
    TKPageEventExit = 2
} TKPageEvent;

typedef void (^TKPageEventHandler)(TKPageEvent event, TKPageContext *page);

@interface TKPageTracking : NSObject

+ (instancetype)shared;
/// 用户使用，用于给无法修改的controller(比如第三方库中的)添加页面跟踪
- (void)registPageContext:(TKPageContext *)pageContext forControllerClass:(Class)controllerClass;
/// 用户使用，用于给无法修改的controller(比如第三方库中的)添加页面跟踪
- (void)registPageContext:(TKPageContext *)pageContext forControllerClassName:(NSString *)controllerClassName;
/// 用户使用，用于注册页面事件监听，注册的handler的生命周期和lifeIndicator一致
- (void)registPageEventLifeIndicator:(id)lifeIndicator handler:(TKPageEventHandler)handler;
/// 最近一次Entry的page
@property (nonatomic, strong) TKPageContext *_Nullable lastEntryPage;


- (TKPageContext* _Nullable)getPageContextFromController:(UIViewController *)controller;
- (void)sendPageLoaded:(TKPageContext *)context;
- (void)sendPageEntry:(TKPageContext *)context;
- (void)sendPageExit:(TKPageContext *)context;

@end

NS_ASSUME_NONNULL_END
