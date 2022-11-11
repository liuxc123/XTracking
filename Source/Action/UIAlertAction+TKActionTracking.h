//
//  UIAlertAction+TKActionTracking.h
//  XTracking
//
//  Created by liuxc on 2022/11/10.
//

#import <UIKit/UIKit.h>

#import "ITKActionObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 @see <ITKActionObject>
 */
@interface UIAlertAction (TKActionTracking) <ITKActionObject>

@end

NS_ASSUME_NONNULL_END
