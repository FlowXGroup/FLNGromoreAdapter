//
//  FLNRewardVideoAd.h
//  FLNReward
//
//  Created by lee on 2025/12/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FLNRewardAdInfo.h"
#import <FLNAdSDK/FLNAdProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@class FLNRewardAd;

/**
 * 激励视频广告代理协议
 * 用于接收激励视频广告的各种事件回调
 */
@protocol FLNRewardAdDelegate <NSObject>

/**
 * 激励视频广告加载成功回调
 */
- (void)rewardVideoAdDidLoad:(FLNRewardAd *)rewardedAd;

/**
 * 激励视频广告加载失败回调
 */
- (void)rewardVideoAd:(FLNRewardAd *)rewardedAd didFailWithError:(NSError *)error;


- (void)rewardVideoAdReadyToPlay:(FLNRewardAd *)rewardedAd;


- (void)rewardVideoAdDidPlayStart:(FLNRewardAd *)rewardedAd;

/**
 * 激励视频广告播放完成回调
 */
- (void)rewardVideoAdDidPlayFinish:(FLNRewardAd *)rewardedAd;


/**
 * 激励视频广告展示成功回调
 */
- (void)rewardVideoAdDidShow:(FLNRewardAd *)rewardedAd;

/**
 * 激励视频广告展示失败回调
 */
- (void)rewardVideoAdShowFailed:(FLNRewardAd *)rewardedAd error:(NSError *)error;

/**
 * 激励视频广告关闭回调
*/
- (void)rewardVideoAdDidClose:(FLNRewardAd *)rewardedAd;

/**
 * 激励视频广告被点击回调
 * @param rewardedAd 激励视频广告对象
 */
- (void)rewardVideoAdDidClicked:(FLNRewardAd *)rewardedAd;

/**
 * 激励视频广告奖励有效回调
 * @param rewardedAd 激励视频广告对象
 * @param info 奖励信息字典
 */
- (void)rewardVideoAdDidRewardEffective:(FLNRewardAd *)rewardedAd info:(NSDictionary *)info;

 

@end

/**
 * 激励视频广告类
 * 用于加载和展示激励视频广告
 */
@interface FLNRewardAd : NSObject<FLNAdProtocol>

/**
 * 激励视频广告代理对象
 * 用于接收广告的各种事件回调
 */
@property (nonatomic, weak) id <FLNRewardAdDelegate> delegate;

/**
 * 视频是否静音
 * 设置为YES时，视频广告将静音播放
 */
@property (nonatomic, assign) BOOL videoMuted;

/**
 * 广告位ID
 * 只读属性，返回初始化时设置的广告位ID
 */
@property (nonatomic, copy, readonly) NSString *posId;

/**
 * 广告请求超时时间,必须在load之前设置
 */
@property (nonatomic, assign) NSTimeInterval timeout;

/**
 * 初始化激励视频广告
 * @param posId 广告位ID
 * @return 激励视频广告实例
 */
- (instancetype)initWithPosId:(NSString *) posId;

/**
 * 加载广告
 * 开始加载激励视频广告
 */
- (void)loadAd;

/**
 * 检查广告是否准备好
 * @return 如果广告已准备好可以展示返回YES，否则返回NO
 */
- (BOOL)isReady;

- (float)eCPM;

/**
 * 从根视图控制器展示广告
 * @param rootViewController 根视图控制器
 */
- (void)presentAdFromRootViewController:(UIViewController *)rootViewController;

@end

NS_ASSUME_NONNULL_END
