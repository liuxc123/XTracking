#import <UIKit/UIKit.h>
#import "TKPageContext.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum TKPageEvent {
    TKPageEventPageLoaded   = 1,
    TKPageEventPageEntry    = 2,
    TKPageEventPageExit     = 3,
    TKPageEventAppStart     = 4,
    TKPageEventAppEnd       = 5,
    TKPageEventAppTerminate = 6,
} TKPageEvent;

typedef void (^TKPageEventHandler)(TKPageEvent event, TKPageContext *page);
typedef NSDate * _Nullable (^TKPageDateHandler)(void);

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
/// 创建当前时间
@property (nonatomic, copy) TKPageDateHandler dateHandler;
/// 获取当前上下文
- (TKPageContext* _Nullable)getPageContextFromController:(UIViewController *)controller;

- (void)sendPageLoaded:(TKPageContext *)context;
- (void)sendPageEntry:(TKPageContext *)context;
- (void)sendPageExit:(TKPageContext *)context;

- (void)sendAppStart:(TKPageContext *)context;
- (void)sendAppEnd:(TKPageContext *)context;
- (void)sendAppTerminate:(TKPageContext *)context;

- (NSDate *)currentDate;

@end

NS_ASSUME_NONNULL_END
