//
//  BUFLNAdBidUtil.m
//  GroMore Custom Adapter ↔ FLNAdSDK
//

#import "BUFLNAdBidUtil.h"

@protocol FLNAdBidNotify <NSObject>
@optional
- (void)sendWinNotificationWithInfo:(NSDictionary<NSString *, NSString *> *)winInfo;
- (void)sendLossNotificationWithInfo:(NSDictionary<NSString *, NSString *> *)lossInfo;
@end

@implementation FLNAdBidUtil

+ (NSError *)errorForEmptySlotID {
    return [NSError errorWithDomain:@"BUFLNAdapter"
                               code:1001
                           userInfo:@{ NSLocalizedDescriptionKey : @"slotID is empty" }];
}

+ (NSString *)ecpmString:(float)ecpm {
    if (ecpm < 0) {
        return nil;
    }
    NSNumber *num = @(ecpm);
    return [num stringValue];
}

+ (NSDictionary *)loadExtWithECPM:(float)ecpm parameter:(NSDictionary *)parameter {
    NSString *price = [self ecpmString:ecpm];
    if (!price) {
        return @{};
    }
    BUMBiddingType biddingType = [parameter[BUMAdLoadingParamBiddingType] integerValue];
    if (biddingType == BUMBiddingTypeMulti) {
        return @{ BUMMediaAdLoadingExtECPMLevel : price };
    }
    return @{ BUMMediaAdLoadingExtECPM : price };
}

+ (NSString *)mappedWinnerAdn:(NSString *)winnerAdnID {
    if (winnerAdnID.length == 0) {
        return @"unknown";
    }
    NSString *raw = winnerAdnID.lowercaseString;
    static NSDictionary<NSString *, NSString *> *map = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = @{
            @"pangle" : @"csj",
            @"csj" : @"csj",
            @"toutiao" : @"csj",
            @"gdt" : @"gdt",
            @"ylh" : @"gdt",
            @"tencent" : @"gdt",
            @"baidu" : @"bd",
            @"bd" : @"bd",
            @"ks" : @"ks",
            @"kuaishou" : @"ks",
            @"sigmob" : @"sigmob",
            @"mtg" : @"mtg",
            @"mintegral" : @"mtg",
            @"inmobi" : @"inmobi",
            @"other" : @"other",
            @"unknown" : @"unknown",
        };
    });
    NSString *mapped = map[raw];
    return mapped.length > 0 ? mapped : @"other";
}

+ (NSString *)mappedLossReason:(NSString *)lossDescription {
    if (lossDescription.length == 0) {
        return @"203";
    }
    NSCharacterSet *nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([lossDescription rangeOfCharacterFromSet:nonDigits].location == NSNotFound) {
        return lossDescription;
    }
    NSString *lower = lossDescription.lowercaseString;
    if ([lower containsString:@"timeout"] || [lower containsString:@"超时"]) {
        return @"100";
    }
    if ([lower containsString:@"price"] || [lower containsString:@"底价"] || [lower containsString:@"low"]) {
        return @"202";
    }
    if ([lower containsString:@"bid"] || [lower containsString:@"竞价"]) {
        return @"203";
    }
    return @"900";
}

+ (void)applyMediaBidResult:(BUMMediaBidResult *)result adObject:(id)adObject {
    if (!result) {
        return;
    }
    id target = adObject ?: result.originNativeAdData;
    if (!target) {
        return;
    }
    id<FLNAdBidNotify> bidObj = target;
    NSString *price = [NSString stringWithFormat:@"%ld", (long)result.winnerPrice];
    NSString *adn = [self mappedWinnerAdn:result.winnerAdnID];
    if (result.win) {
        if (![bidObj respondsToSelector:@selector(sendWinNotificationWithInfo:)]) {
            return;
        }
        NSMutableDictionary<NSString *, NSString *> *info = [NSMutableDictionary dictionary];
        info[@"second_price"] = price;
        info[@"winner_adn"] = adn;
        [bidObj sendWinNotificationWithInfo:[info copy]];
    } else {
        if (![bidObj respondsToSelector:@selector(sendLossNotificationWithInfo:)]) {
            return;
        }
        NSMutableDictionary<NSString *, NSString *> *info = [NSMutableDictionary dictionary];
        info[@"winner_price"] = price;
        info[@"winner_adn"] = adn;
        info[@"loss_reason"] = [self mappedLossReason:result.lossDescription];
        [bidObj sendLossNotificationWithInfo:[info copy]];
    }
}

@end
