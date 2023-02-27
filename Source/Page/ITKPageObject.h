//
//  ITKPageObject.h
//  XTracking
//
//  Created by liuxc on 2023/2/27.
//

#import <Foundation/Foundation.h>
#import "TKPageContext.h"

NS_ASSUME_NONNULL_BEGIN

/// 代表抽象出来的Page
@protocol ITKPageObject <NSObject>

- (void)pageEntry:(TKPageContext *)context;
- (void)pageExit:(TKPageContext *)context;

@end

NS_ASSUME_NONNULL_END