//
//  TKPageContext.m
//  XTracking
//
//  Created by liuxc on 2022/11/10.
//

#import "TKPageContext.h"

@implementation TKPageContext

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithPageId:(NSString *)pageId userData:(id)userData {
    self = [super init];
    if (self) {
        self.pageId = pageId;
        self.userData = userData;
    }
    return self;
}

- (void)updatePageEntryTime {
    self.pageEntryTime = @((long long)([[NSDate date] timeIntervalSince1970] * 1000));
}

@end
