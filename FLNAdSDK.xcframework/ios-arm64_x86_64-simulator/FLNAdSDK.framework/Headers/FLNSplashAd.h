//
//  FLNSplashAd.h
//  FLNSplash
//
//  Created by lee on 2025/12/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FLNAdSDK/FLNAdProtocol.h>

NS_ASSUME_NONNULL_BEGIN


@class FLNSplashAd;

/**
 * 开屏广告代理协议
 * 用于接收开屏广告的各种事件回调
 */
@protocol FLNSplashAdDelegate <NSObject>
@optional
/**
 * 开屏广告加载成功回调
 * @param splashAd 开屏广告对象
 */
- (void)splashAdDidLoad:(FLNSplashAd *)splashAd;

/**
 * 开屏广告加载失败回调
 * @param splashAd 开屏广告对象
 * @param error 错误信息
 */
- (void)splashAdLoadFail:(FLNSplashAd *)splashAd error:(NSError *_Nullable)error;

/**
 * 开屏广告展示成功回调
 * @param splashAd 开屏广告对象
 */
- (void)splashAdDidShow:(FLNSplashAd *)splashAd;

/**
 * 开屏广告展示失败回调
 * @param splashAd 开屏广告对象
 * @param error 错误信息
 */
- (void)splashAdShowFailed:(FLNSplashAd *)splashAd withError:(NSError *)error;

/**
 * 开屏广告被点击回调
 * @param splashAd 开屏广告对象
 */
- (void)splashAdClicked:(FLNSplashAd *)splashAd;

/**
 * 开屏广告关闭回调
 * @param splashAd 开屏广告对象
 */
- (void)splashAdClosed:(FLNSplashAd *)splashAd;

- (void)splashAdSkip:(FLNSplashAd * )splashAd time:(NSInteger)time;

@end

/**
 * 开屏广告类
 * 用于加载和展示开屏广告
 */
@interface FLNSplashAd : NSObject<FLNAdProtocol>

/**
 * 开屏广告代理对象
 * 用于接收广告的各种事件回调
 */
@property (nonatomic, weak) id<FLNSplashAdDelegate> delegate;

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
 * 初始化开屏广告
 * @param posId 广告位ID
 * @return 开屏广告实例
 */
- (instancetype)initWithPosId:(NSString *) posId;

/**
 * 加载广告
 * 开始加载开屏广告
 */
- (void)loadAd;

/**
 * 检查广告是否准备好
 * @return 如果广告已准备好可以展示返回YES，否则返回NO
 */
- (BOOL)isReady;


- (float)eCPM;

/**
 * 在窗口中展示广告
 * @param window 要展示广告的窗口
 */
- (void)showAdInWindow:(UIWindow *)window;

/**
 * 在窗口中展示广告；底部可贴宿主自定义视图（如 App Logo 区）
 * @param window 要展示广告的窗口
 * @param bottomView 贴屏幕底部；传 nil 则全屏。有值时高度取该 view 自身高度，且不超过屏高的 25%
 */
- (void)showAdInWindow:(UIWindow *)window withBottomView:(UIView * _Nullable)bottomView;

@end

NS_ASSUME_NONNULL_END
