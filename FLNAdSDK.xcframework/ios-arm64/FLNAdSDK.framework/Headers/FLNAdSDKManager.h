//
//  FLNAdSDKManager.h
//  FLNAdSDK
//
//  Created by lee on 2025/12/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FLNAdSDK/FLNInitConfig.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * SDK初始化完成回调
 * @param success 是否成功
 * @param error 错误信息，如果成功则为nil
 */
typedef void (^FLNAdCompletionHandler)(BOOL success, NSError * _Nullable error);

/**
 * 广告SDK管理器
 * 负责SDK的初始化和配置管理
 */
@interface FLNAdSDKManager : NSObject

/**
 * 获取单例实例
 * @return SDK管理器单例
 */
+ (instancetype)sharedInstance;

/**
 * 启动SDK并初始化
 * @param completionHandler 初始化完成回调
 */
- (void)startWithConfig:(FLNInitConfig *)config completionHandler:(FLNAdCompletionHandler)completionHandler;

 
- (NSString *)getAppId;
/**
 * 获取SDK版本号
 * @return SDK版本号字符串
 */
+ (NSString *)sdkVersion;

@end

NS_ASSUME_NONNULL_END
