//
//  TKActionContext.m
//  XTracking
//
//  Created by liuxc on 2022/11/10.
//

#import "TKActionContext.h"

@implementation TKActionContext

- (instancetype)initWithTrackingId:(NSString *)trackingId userData:(id)userData {
    self = [super init];
    if (self) {
        self.trackingId = trackingId;
        self.userData = userData;
    }
    return self;
}

@end
