

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

- (void)updatePageEntryDuration {
    // 退出页面时间戳 - 进入页面时间戳 - 进入后台时长
    double pageExitTimeStamp = self.pageExitTimeStamp.doubleValue;
    double pageEntryTimeStamp = self.pageEntryTimeStamp.doubleValue;
    double appEndDuration = self.appEndDuration.doubleValue;
    self.pageEntryDuration = @(pageExitTimeStamp - pageEntryTimeStamp - appEndDuration);
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

- (void)updateAppEndTimeStamp {
    self.appEndTimeStamp = @((long long)([[[TKPageTracking shared] currentDate] timeIntervalSince1970]));
}

- (void)updatePageEntryTimeStamp {
    self.pageEntryTimeStamp = @((long long)([[[TKPageTracking shared] currentDate] timeIntervalSince1970]));
}

- (void)updatePageExitTimeStamp {
    self.pageExitTimeStamp = @((long long)([[[TKPageTracking shared] currentDate] timeIntervalSince1970]));
}

@end
