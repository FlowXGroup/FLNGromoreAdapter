//
//  FLNInterstitialAd.h
//  FLNInterstitial
//
//  Created by lee on 2025/12/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FLNAdSDK/FLNAdProtocol.h>

NS_ASSUME_NONNULL_BEGIN


@class FLNInterstitialAd;

/**
 * 插屏广告代理协议
 * 用于接收插屏广告的各种事件回调
 */
@protocol FLNInterstitialAdDelegate <NSObject>

/**
 * 插屏广告加载成功回调
 * @param interstitialAd 插屏广告对象
 */
- (void)interstitialAdDidLoad:(FLNInterstitialAd *)interstitialAd;


/**
 * 插屏广告加载失败回调
 * @param interstitialAd 插屏广告对象
 * @param error 错误信息
 */
- (void)interstitialAd:(FLNInterstitialAd *)interstitialAd didFailWithError:(NSError *)error;

/**
 * 插屏广告展示成功回调
 * @param interstitial 插屏广告对象
 */
- (void)interstitialAdDidShow:(FLNInterstitialAd *)interstitial;

/**
 * 插屏广告展示失败回调
 * @param interstitialAd 插屏广告对象
 * @param error 错误信息
 */
- (void)interstitialAdShowFailed:(FLNInterstitialAd *)interstitialAd error:(NSError *)error;

/**
 * 插屏广告关闭回调。
 * @param interstitialAd 插屏广告对象
 */
- (void)interstitialAdDidClose:(FLNInterstitialAd *)interstitialAd;

/**
 * 插屏广告被点击回调
 * @param interstitialAd 插屏广告对象
 */
- (void)interstitialAdDidClicked:(FLNInterstitialAd *)interstitialAd;

@end

/**
 * 插屏广告类
 * 用于加载和展示插屏广告
 */
@interface FLNInterstitialAd : NSObject<FLNAdProtocol>

/**
 * 插屏广告代理对象
 * 用于接收广告的各种事件回调
 */
@property (nonatomic,weak) id <FLNInterstitialAdDelegate>delegate;

 
/**
 * 广告位ID
 * 只读属性，返回初始化时设置的广告位ID
 */
@property (nonatomic, copy, readonly) NSString *posId;

/**
 * 初始化插屏广告
 * @param posId 广告位ID
 * @return 插屏广告实例
 */
- (instancetype)initWithPosId:(NSString *) posId;

/**
 * 加载广告
 * 开始加载插屏广告
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
