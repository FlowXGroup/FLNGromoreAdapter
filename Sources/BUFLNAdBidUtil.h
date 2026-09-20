//
//  BUFLNAdBidUtil.h
//  GroMore Custom Adapter ↔ FLNAdSDK
//

#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLNAdBidUtil : NSObject

+ (NSError *)errorForEmptySlotID;

/// 将 eCPM（分，可小数）转为 GroMore load ext；无效（<0）返回空字典
+ (NSDictionary *)loadExtWithECPM:(float)ecpm parameter:(nullable NSDictionary *)parameter;

/// 透传竞胜/竞败到 FLNAdProtocol（second_price / winner_price / winner_adn / loss_reason）。
/// 对齐 FLNAdSDK 6.2.0.19：value 均为 NSString，价格单位分。
+ (void)applyMediaBidResult:(BUMMediaBidResult *)result adObject:(nullable id)adObject;

@end

NS_ASSUME_NONNULL_END
