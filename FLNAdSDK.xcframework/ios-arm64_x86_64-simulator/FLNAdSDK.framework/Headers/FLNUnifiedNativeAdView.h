//
//  FLNUnifiedNativeAdView.h
//  FLNMobSDK
//
//  Created by nimomeng on 2018/10/10.
//  Copyright © 2018 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLNUnifiedNativeAdDataObject.h"

 
NS_ASSUME_NONNULL_BEGIN

@class FLNUnifiedNativeAdView;

@protocol FLNUnifiedNativeAdViewDelegate <FLNAdProtocol>

@optional
/**
 广告曝光回调

 @param unifiedNativeAdView FLNUnifiedNativeAdView 实例
 */
- (void)fln_unifiedNativeAdViewDidExpose:(FLNUnifiedNativeAdView *)unifiedNativeAdView;


/**
 广告点击回调

 @param unifiedNativeAdView FLNUnifiedNativeAdView 实例
 */
- (void)fln_unifiedNativeAdViewDidClick:(FLNUnifiedNativeAdView *)unifiedNativeAdView;


/**
 广告详情页关闭回调

 @param unifiedNativeAdView FLNUnifiedNativeAdView 实例
 */
- (void)fln_unifiedNativeAdDetailViewClosed:(FLNUnifiedNativeAdView *)unifiedNativeAdView;


/**
 广告详情页面即将展示回调

 @param unifiedNativeAdView FLNUnifiedNativeAdView 实例
 */
- (void)fln_unifiedNativeAdDetailViewWillPresentScreen:(FLNUnifiedNativeAdView *)unifiedNativeAdView;

@end

@interface FLNUnifiedNativeAdView : UIView

/**
 绑定的数据对象
 */
@property (nonatomic, strong, readonly) FLNUnifiedNativeAdDataObject *dataObject;

/**
 广告 LogoView，自动生成，可自定义布局
 */
//@property (nonatomic, strong, readonly) FLNLogoView *logoView;

/**
 广告 View 时间回调对象
 */
@property (nonatomic, weak) id<FLNUnifiedNativeAdViewDelegate> delegate;

/**
 *  viewControllerForPresentingModalView
 *  详解：开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *viewController;

/**

 @warning 调用方法之前请先判断[dataObject isAdValid]是否为YES，当为NO时调用不生效
 @warning 需要注意的是 -[FLNUnifiedNativeAdView registerDataObject:clickableViews:]方法需要避免重复多次调用的情况
 @warning 当广告不需要展示并且销毁的时候，需要调用 -[FLNUnifiedNativeAdView unregisterDataObject]方法，即registerDataObject方法需要与unregisterDataObject方法成对调用

 @param dataObject 数据对象，必传字段
 @param clickableViews 可点击的视图数组，此数组内的广告元素才可以响应广告对应的点击事件
 */
- (void)registerDataObject:(FLNUnifiedNativeAdDataObject *_Nonnull)dataObject
            clickableViews:(NSArray<UIView *> *_Nonnull)clickableViews;
 
/**
 注销数据对象，在 tableView、collectionView 等场景需要复用 FLNUnifiedNativeAdView 时，
 需要在合适的时机，例如 cell 的 prepareForReuse 方法内执行 unregisterDataObject 方法，
 将广告对象与 FLNUnifiedNativeAdView 解绑，具体可参考示例 demo 的 UnifiedNativeAdBaseTableViewCell 类
 */
- (void)unregisterDataObject;

@end

NS_ASSUME_NONNULL_END
