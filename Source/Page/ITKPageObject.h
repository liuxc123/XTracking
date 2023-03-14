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

@optional
- (void)appStart:(TKPageContext *)context;
- (void)appEnd:(TKPageContext *)context;
- (void)appTerminate:(TKPageContext *)context;

- (void)pageLoaded:(TKPageContext *)context;
- (void)pageEntry:(TKPageContext *)context;
- (void)pageExit:(TKPageContext *)context;

@end

NS_ASSUME_NONNULL_END
