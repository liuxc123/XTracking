#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 代表一个抽象的页面
@interface TKPageContext : NSObject

- (instancetype)init; //for swift unwrap issues

/// 页面的跟踪Id，由用户使用，xTracking并不依赖这个属性
@property (nonatomic, copy) NSString *_Nonnull pageId;
/// 额外数据
@property (nonatomic, strong) id _Nullable userData;


/// 统计页面浏览时长（退出页面时间戳 - 进入页面时间戳 - 进入后台时长），不需要用户维护
@property (nonatomic, strong) NSNumber *_Nullable pageBrowseDuration;
/// 统计进入后台时长（进入后台时间戳 - 回到前台时间戳），不需要用户维护
@property (nonatomic, strong) NSNumber *_Nullable appEndDuration;

/// 上一次进入前台时间戳，不需要用户维护
@property (nonatomic, strong) NSNumber *_Nullable appStartTimeStamp;
/// 上一次进入后台时间戳，不需要用户维护
@property (nonatomic, strong) NSNumber *_Nullable appEndTimeStamp;

/// 页面加载时间戳，不需要用户维护
@property (nonatomic, strong) NSNumber *_Nullable pageLoadedTimeStamp;
/// 页面进入时间戳，不需要用户维护
@property (nonatomic, strong) NSNumber *_Nullable pageEntryTimeStamp;
/// 页面退出时间戳，不需要用户维护
@property (nonatomic, strong) NSNumber *_Nullable pageExitTimeStamp;

- (void)updatePageBrowseDuration;

- (void)updateAppEndDuration;

- (void)updateAppStartTimeStamp;

- (void)updateAppEndTimeStamp;

- (void)updatePageLoadedTimeStamp;

- (void)updatePageEntryTimeStamp;

- (void)updatePageExitTimeStamp;

- (instancetype)initWithPageId:(NSString *_Nullable)pageId userData:(id _Nullable)userData;

@end

NS_ASSUME_NONNULL_END
