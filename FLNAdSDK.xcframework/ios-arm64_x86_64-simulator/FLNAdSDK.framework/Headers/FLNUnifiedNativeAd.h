//
//  FLNUnifiedNativeAd.h
//  GDTMobSDK
//
//  Created by nimomeng on 2018/10/10.
//  Copyright © 2018 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLNUnifiedNativeAdDataObject.h"
#import "FLNUnifiedNativeAdView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FLNUnifiedNativeAdDelegate <NSObject>

/**
 广告数据回调

 @param unifiedNativeAdDataObjects 广告数据数组
 @param error 错误信息
 */
- (void)fln_unifiedNativeAdLoaded:(NSArray<FLNUnifiedNativeAdDataObject *> * _Nullable)unifiedNativeAdDataObjects error:(NSError * _Nullable)error;
@end

@interface FLNUnifiedNativeAd : NSObject<FLNAdProtocol>


@property (nonatomic, weak) id<FLNUnifiedNativeAdDelegate> delegate;


/**
 构造方法

 @param posId 广告位ID
 @return FLNUnifiedNativeAd 实例
 */
- (instancetype)initWithPosId:(NSString *)posId;


/**
 加载广告
 */
- (void)loadAd;

 
@end
NS_ASSUME_NONNULL_END
