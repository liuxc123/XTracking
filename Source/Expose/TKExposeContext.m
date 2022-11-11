//
//  TKExposeContext.m
//  XTracking
//
//  Created by liuxc on 2022/11/10.
//

#import "TKExposeContext.h"

@implementation TKExposeContext

- (instancetype)initWithTrackingId:(NSString * _Nullable)trackingId
                          userData:(id _Nullable)userData {
    self = [super init];
    if (self) {
        self.trackingId = trackingId;
        self.userData = userData;
    }
    return self;
}

@end
