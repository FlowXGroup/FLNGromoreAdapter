//
//  BUFLNCustomRewardedVideoAdapter.m
//

#import "BUFLNCustomRewardedVideoAdapter.h"
#import "BUFLNAdBidUtil.h"
#import <FLNAdSDK/FLNRewardAd.h>

@interface BUFLNCustomRewardedVideoAdapter () <FLNRewardAdDelegate>
@property (nonatomic, strong, nullable) FLNRewardAd *rewardAd;
@property (nonatomic, assign) BOOL didFireVideoDidLoad;
@property (nonatomic, copy) NSDictionary *lastLoadParameter;
@end

@implementation BUFLNCustomRewardedVideoAdapter

- (BUMMediatedAdStatus)mediatedAdStatus {
    if (self.rewardAd && [self.rewardAd isReady]) {
        return BUMMediatedAdStatusNormal;
    }
    return BUMMediatedAdStatusUnknown;
}

- (void)loadRewardedVideoAdWithSlotID:(NSString *)slotID andParameter:(NSDictionary *)parameter {
    if (slotID.length == 0) {
        [self.bridge rewardedVideoAd:self didLoadFailWithError:[FLNAdBidUtil errorForEmptySlotID] ext:@{}];
        return;
    }
    self.lastLoadParameter = parameter ?: @{};
    self.didFireVideoDidLoad = NO;
    self.rewardAd = [[FLNRewardAd alloc] initWithPosId:slotID];
    self.rewardAd.delegate = self;
    if ([parameter[BUMAdLoadingParamRVIsMute] respondsToSelector:@selector(boolValue)]) {
        self.rewardAd.videoMuted = [parameter[BUMAdLoadingParamRVIsMute] boolValue];
    }
    id timeoutVal = parameter[BUMAdLoadingParamSPTolerateTimeout];
    if ([timeoutVal respondsToSelector:@selector(doubleValue)] && [timeoutVal doubleValue] > 0) {
        self.rewardAd.timeout = [timeoutVal doubleValue];
    }
    [self.rewardAd loadAd];
}

- (BOOL)showAdFromRootViewController:(UIViewController *)viewController parameter:(NSDictionary *)__unused parameter {
    if (!viewController || !self.rewardAd || ![self.rewardAd isReady]) {
        return NO;
    }
    [self.rewardAd presentAdFromRootViewController:viewController];
    return YES;
}

- (void)didReceiveBidResult:(BUMMediaBidResult *)result {
    [FLNAdBidUtil applyMediaBidResult:result adObject:self.rewardAd];
}

#pragma mark - FLNRewardAdDelegate

- (void)rewardVideoAdDidLoad:(FLNRewardAd *)rewardedAd {
    NSDictionary *ext = [FLNAdBidUtil loadExtWithECPM:[rewardedAd eCPM] parameter:self.lastLoadParameter];
    [self.bridge rewardedVideoAd:self didLoadWithExt:ext];
}

- (void)rewardVideoAd:(FLNRewardAd *)__unused rewardedAd didFailWithError:(NSError *)error {
    [self.bridge rewardedVideoAd:self didLoadFailWithError:error ext:@{}];
}

- (void)rewardVideoAdReadyToPlay:(FLNRewardAd *)__unused rewardedAd {
    if (!self.didFireVideoDidLoad) {
        self.didFireVideoDidLoad = YES;
        [self.bridge rewardedVideoAdVideoDidLoad:self];
    }
}

- (void)rewardVideoAdDidPlayStart:(FLNRewardAd *)__unused rewardedAd {
}

- (void)rewardVideoAdDidPlayFinish:(FLNRewardAd *)__unused rewardedAd {
    [self.bridge rewardedVideoAd:self didPlayFinishWithError:nil];
}

- (void)rewardVideoAdDidShow:(FLNRewardAd *)__unused rewardedAd {
    [self.bridge rewardedVideoAdDidVisible:self];
}

- (void)rewardVideoAdShowFailed:(FLNRewardAd *)__unused rewardedAd error:(NSError *)error {
    [self.bridge rewardedVideoAdDidShowFailed:self error:error];
}

- (void)rewardVideoAdDidClose:(FLNRewardAd *)__unused rewardedAd {
    [self.bridge rewardedVideoAdDidClose:self];
    self.rewardAd = nil;
}

- (void)rewardVideoAdDidClicked:(FLNRewardAd *)__unused rewardedAd {
    [self.bridge rewardedVideoAdDidClick:self];
}

- (void)rewardVideoAdDidRewardEffective:(FLNRewardAd *)__unused rewardedAd info:(NSDictionary *)info {
    [self.bridge rewardedVideoAd:self didServerRewardSuccessWithInfo:^(BUMAdapterRewardAdInfo *_Nonnull rewardInfo) {
        id name = info[@"reward_name"] ?: info[@"rewardName"];
        id amount = info[@"reward_amount"] ?: info[@"rewardAmount"];
        id trade = info[@"trade_id"] ?: info[@"tradeId"];
        if ([name isKindOfClass:[NSString class]]) {
            rewardInfo.rewardName = name;
        }
        if ([amount respondsToSelector:@selector(integerValue)]) {
            rewardInfo.rewardAmount = [amount integerValue];
        }
        if ([trade isKindOfClass:[NSString class]]) {
            rewardInfo.tradeId = trade;
        }
        rewardInfo.verify = YES;
    }];
}

@end
