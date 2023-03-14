

#import "TKPageContext.h"
#import "UIViewController+TKPageTracking.h"
#import "TKPageTracking.h"

@implementation TKPageContext

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithPageId:(NSString *_Nullable)pageId userData:(id _Nullable)userData {
    self = [super init];
    if (self) {
        self.pageId = pageId;
        self.userData = userData;
    }
    return self;
}

- (void)updatePageBrowseDuration {
    // 退出页面时间戳 - 进入页面时间戳 - 进入后台时长
    double pageEndTimeStamp = self.pageExitTimeStamp.intValue == 0 ? self.appEndTimeStamp.doubleValue : self.pageExitTimeStamp.doubleValue;
    double pageEntryTimeStamp = self.pageEntryTimeStamp.doubleValue;
    double appEndDuration = self.appEndDuration.doubleValue;
    self.pageBrowseDuration = @(pageEndTimeStamp - pageEntryTimeStamp - appEndDuration);
}

- (void)updateAppEndDuration {
    // 进入后台时间戳 - 回到前台时间戳
    NSNumber *currentTimeStamp = @((long long)([[[TKPageTracking shared] currentDate] timeIntervalSince1970]));
    if (self.appEndTimeStamp && self.appEndTimeStamp != 0) {
        double appEndDuration = self.appEndDuration.doubleValue;
        double currentAppEndTime = currentTimeStamp.doubleValue - self.appEndTimeStamp.doubleValue;
        self.appEndDuration = @(appEndDuration + currentAppEndTime);
    }
}

- (void)updateAppStartTimeStamp {
    self.appStartTimeStamp = @((long long)([[[TKPageTracking shared] currentDate] timeIntervalSince1970]));
}

- (void)updateAppEndTimeStamp {
    self.appEndTimeStamp = @((long long)([[[TKPageTracking shared] currentDate] timeIntervalSince1970]));
}

- (void)updatePageLoadedTimeStamp {
    self.pageLoadedTimeStamp = @((long long)([[[TKPageTracking shared] currentDate] timeIntervalSince1970]));
}

- (void)updatePageEntryTimeStamp {
    self.pageEntryTimeStamp = @((long long)([[[TKPageTracking shared] currentDate] timeIntervalSince1970]));
}

- (void)updatePageExitTimeStamp {
    self.pageExitTimeStamp = @((long long)([[[TKPageTracking shared] currentDate] timeIntervalSince1970]));
}

@end
