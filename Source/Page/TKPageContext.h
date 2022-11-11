//
//  TKPageContext.h
//  XTracking
//
//  Created by liuxc on 2022/11/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKPageContext : NSObject

/// 页面的跟踪Id，由用户使用，xTracking并不依赖这个属性
@property (nonatomic, copy, nullable) NSString *pageId;

/// 页面进入时间，不需要用户维护(毫秒级时间戳)
@property (nonatomic, strong, nullable) NSNumber *pageEntryTime;
@property (nonatomic, strong, nullable) id userData;
- (void)updatePageEntryTime;

- (instancetype)init;

- (instancetype)initWithPageId:(NSString* _Nullable)pageId
                      userData:(id _Nullable)userData;

@end

NS_ASSUME_NONNULL_END
