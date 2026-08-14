//
//  FLNAdProtocol.h
//  FLNAdSDK
//
//  Created by fan on 2026/2/22.
//

#ifndef FLNAdProtocol_h
#define FLNAdProtocol_h

NS_ASSUME_NONNULL_BEGIN

/**
 竞价字典字段说明（`sendWinNotificationWithInfo:` / `sendLossNotificationWithInfo:`）。
 value 均为 `NSString`；价格单位：分（可为小数）。

 winner_adn（胜出方 ADN / 输给哪家）：
   unknown  未知
   csj      穿山甲
   gdt      优量汇
   bd       百度联盟/百青藤
   ks       快手联盟
   sigmob   Sigmob
   mtg      Mintegral
   inmobi   InMobi
   other    其它

 loss_reason（竞败原因，仅竞败）：
   100 返回超时
   201 缺少竞价价格
   202 出价低于底价
   203 竞价失败
   900 其他原因
 */
@protocol FLNAdProtocol <NSObject>

@optional
/**
 *  竞胜之后调用，需要在调用广告 show 之前调用。
 *
 *  @param winInfo 字典类型；各 value 请传 `NSString`。
 *  - second_price（次高价，结算价）
 *  - winner_adn（见上方说明）
 */
- (void)sendWinNotificationWithInfo:(NSDictionary<NSString *, NSString *> *)winInfo;

/**
 *  竞败之后或未参竞调用。
 *
 *  @param lossInfo 字典类型；各 value 请传 `NSString`。
 *  - winner_price（竞赢方最高价）
 *  - winner_adn（见上方说明）
 *  - loss_reason（见上方说明）
 */
- (void)sendLossNotificationWithInfo:(NSDictionary<NSString *, NSString *> *)lossInfo;

@end

NS_ASSUME_NONNULL_END

#endif /* FLNAdProtocol_h */
