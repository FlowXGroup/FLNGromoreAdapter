//
//  BUFLNInitHelper.h
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUFLNInitHelper : NSObject

/// Config 调用：只落地 appId，不初始化 SDK。
+ (void)saveAppId:(nullable NSString *)appId;

/// 广告 load 前调用：已成功 → 立刻 YES；进行中 → 挂起等结果；未初始化 → 落地 appId / @"5209496" 再 init（全局一次）。
+ (void)ensureReadyForAdLoad:(void (^)(BOOL success, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
