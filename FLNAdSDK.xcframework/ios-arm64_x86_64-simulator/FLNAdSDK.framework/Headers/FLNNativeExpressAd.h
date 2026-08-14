//
//  FLNNativeExpressAd.h
//  FLNExpressNative
//
//  Created by lee on 2025/12/15.
//

#import <Foundation/Foundation.h>
#import <FLNAdSDK/FLNAdProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@class FLNNativeExpressAd;
@class FLNNativeExpressAdView;

/**
 * 原生模板广告代理协议
 * 用于接收原生模板广告的各种事件回调
 */
@protocol FLNNativeExpressAdDelegate <NSObject>
@optional
/**
 * 原生模板广告加载成功回调
 * @param nativeExpressAd 原生模板广告对象
 */
- (void)nativeExpressAdDidLoad:(FLNNativeExpressAd *)nativeExpressAd;

/**
 * 原生模板广告加载失败回调
 * @param nativeExpressAd 原生模板广告对象
 * @param error 错误信息
 */
- (void)nativeExpressAdFailToLoad:(FLNNativeExpressAd *)nativeExpressAd error:(NSError *)error;

/**
 * 原生模板广告视图渲染成功回调
 * @param nativeExpressAd 原生模板广告视图
 */
- (void)nativeExpressAdViewRenderSuccess:(FLNNativeExpressAd *)nativeExpressAd
                     nativeExpressAdView:(NSArray<__kindof FLNNativeExpressAdView *> *)nativeExpressAdViews;

/**
 * 原生模板广告视图渲染失败回调
 * @param error 错误信息
 */
- (void)nativeExpressAdViewRenderFail:(FLNNativeExpressAd *)nativeExpressAd error:(NSError *)error;

/**
 * 原生模板广告视图展示成功回调
 * @param nativeExpressAdView 原生模板广告视图
 */
- (void)nativeExpressAdViewDidShow:(FLNNativeExpressAd *)nativeExpressAd
               nativeExpressAdView:(FLNNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生模板广告视图被点击回调
 * @param nativeExpressAdView 原生模板广告视图
 */
- (void)nativeExpressAdViewClicked:(FLNNativeExpressAd *)nativeExpressAd
               nativeExpressAdView:(FLNNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生模板广告视图关闭回调
 * @param nativeExpressAdView 原生模板广告视图
 */
- (void)nativeExpressAdViewClosed:(FLNNativeExpressAd *)nativeExpressAd
              nativeExpressAdView:(FLNNativeExpressAdView *)nativeExpressAdView;

@end

/**
 * 原生模板广告类
 * 用于加载原生模板广告
 */
@interface FLNNativeExpressAd : NSObject<FLNAdProtocol>

/**
 * 原生模板广告代理对象
 * 用于接收广告的各种事件回调
 */
@property (nonatomic, weak) id<FLNNativeExpressAdDelegate> delegate;


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
 * 初始化原生模板广告
 * @param posId 广告位ID
 * @param width 广告尺寸
 * @return 原生模板广告实例
 */
- (instancetype)initWithPosId:(NSString *) posId width:(CGFloat)width;

/**
 * 加载广告
 * @param count 要加载的广告数量
 */
- (void)loadAd:(NSInteger)count;

/**
 * 广告是否准备就绪
 * @return YES 表示广告可以展示
 */
- (BOOL)isReady;

@end

NS_ASSUME_NONNULL_END
