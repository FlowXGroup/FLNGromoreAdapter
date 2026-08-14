//
//  FLNUnifiedNativeAdDataObject.h
//  FLNMobSDK
//
//  Created by nimomeng on 2018/10/10.
//  Copyright © 2018 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FLNAdProtocol.h"
NS_ASSUME_NONNULL_BEGIN


@interface FLNUnifiedNativeAdDataObject : NSObject <FLNAdProtocol>

/**
 广告标题
 */
@property (nonatomic, copy, readonly) NSString * _Nullable title;

/**
 广告描述
 */
@property (nonatomic, copy, readonly) NSString *desc;

/**
 素材宽度，单图广告代表大图 imageUrl 宽度、多图广告代表小图 mediaUrlList 宽度
 */
@property (nonatomic, readonly) NSInteger imageWidth;

/**
 素材高度，单图广告代表大图 imageUrl 高度、多图广告代表小图 mediaUrlList 高度
 */
@property (nonatomic, readonly) NSInteger imageHeight;

/**
 应用类广告App 图标Url
 */
@property (nonatomic, copy, readonly) NSString *iconUrl;

/**
 广告大图Url, 建议使用 bindImageViews:placeholder: 方法替代
 */
@property (nonatomic, copy, readonly) NSArray *imageUrl;
 

@property (nonatomic, copy, readonly) NSString *videoUrl;

/**
 视频封面图 URL；无视频或服务端未下发时可为空
 */
@property (nonatomic, copy, readonly, nullable) NSString *videoImageUrl;

/**
 视频时长，单位秒
 */
@property (nonatomic, readonly) NSInteger videoDuration;

/**
 应用类广告的价格
 */
@property (nonatomic, strong, readonly) NSNumber * _Nullable appPrice;

/**
 是否为应用类广告
 */
@property (nonatomic, readonly) BOOL isAppAd;

 

/**
 返回广告的eCPM，单位：分（可为小数）
 
 @return 成功返回一个大于等于0的值，-1表示无权限或后台出现异常
 */
@property (nonatomic, readonly) float eCPM;

 

/**
 广告对应的按钮展示文案
 此字段可能为空
 */
@property (nonatomic, readonly) NSString * _Nullable buttonText;

/**
 广告对应的CTA文案，自定义CTA视图时建议使用此字段
 广告对应的callToAction文案，比如“立即预约”或“电话咨询”, 自定义callToAction视图时建议使用此字段

 该字段在部分广告类型中可能为空
 */
@property (nonatomic, readonly) NSString * _Nullable callToAction;
 
 

/**
 *  广告是否有效，以下情况会返回 NO，建议在展示广告之前判断，否则会影响计费或展示失败
 *  a. 广告缓存已过期
 *  b. 广告已展示过
 */
@property (nonatomic, readonly) BOOL isAdValid;

/**
 判断两个自渲染2.0广告数据是否相等

 @param dataObject 需要对比的自渲染2.0广告数据对象
 @return YES or NO
 */
- (BOOL)equalsAdData:(FLNUnifiedNativeAdDataObject *)dataObject;

@end

NS_ASSUME_NONNULL_END
