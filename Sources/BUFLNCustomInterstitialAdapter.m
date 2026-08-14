//
//  BUFLNCustomInterstitialAdapter.m
//

#import "BUFLNCustomInterstitialAdapter.h"
#import "BUFLNAdBidUtil.h"
#import <FLNAdSDK/FLNInterstitialAd.h>

@interface BUFLNCustomInterstitialAdapter () <FLNInterstitialAdDelegate>
@property (nonatomic, strong, nullable) FLNInterstitialAd *interstitialAd;
@property (nonatomic, copy) NSDictionary *lastLoadParameter;
@end

@implementation BUFLNCustomInterstitialAdapter

- (BUMMediatedAdStatus)mediatedAdStatus {
    if (self.interstitialAd && [self.interstitialAd isReady]) {
        return BUMMediatedAdStatusNormal;
    }
    return BUMMediatedAdStatusUnknown;
}

- (void)loadInterstitialAdWithSlotID:(NSString *)slotID andSize:(CGSize)__unused size parameter:(NSDictionary *)parameter {
    if (slotID.length == 0) {
        [self.bridge interstitialAd:self didLoadFailWithError:[FLNAdBidUtil errorForEmptySlotID] ext:@{}];
        return;
    }
    self.lastLoadParameter = parameter ?: @{};
    self.interstitialAd = [[FLNInterstitialAd alloc] initWithPosId:slotID];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAd];
}

- (BOOL)showAdFromRootViewController:(UIViewController *)viewController parameter:(NSDictionary *)__unused parameter {
    if (!viewController || !self.interstitialAd || ![self.interstitialAd isReady]) {
        return NO;
    }
    [self.interstitialAd presentAdFromRootViewController:viewController];
    return YES;
}

- (void)didReceiveBidResult:(BUMMediaBidResult *)result {
    [FLNAdBidUtil applyMediaBidResult:result adObject:self.interstitialAd];
}

#pragma mark - FLNInterstitialAdDelegate

- (void)interstitialAdDidLoad:(FLNInterstitialAd *)interstitialAd {
    NSDictionary *ext = [FLNAdBidUtil loadExtWithECPM:[interstitialAd eCPM] parameter:self.lastLoadParameter];
    [self.bridge interstitialAd:self didLoadWithExt:ext];
}

- (void)interstitialAd:(FLNInterstitialAd *)__unused interstitialAd didFailWithError:(NSError *)error {
    [self.bridge interstitialAd:self didLoadFailWithError:error ext:@{}];
}

- (void)interstitialAdDidShow:(FLNInterstitialAd *)__unused interstitial {
    [self.bridge interstitialAdDidVisible:self];
}

- (void)interstitialAdShowFailed:(FLNInterstitialAd *)__unused interstitialAd error:(NSError *)error {
    [self.bridge interstitialAdDidShowFailed:self error:error];
}

- (void)interstitialAdDidClose:(FLNInterstitialAd *)__unused interstitialAd {
    [self.bridge interstitialAdDidClose:self];
    self.interstitialAd = nil;
}

- (void)interstitialAdDidClicked:(FLNInterstitialAd *)__unused interstitialAd {
    [self.bridge interstitialAdDidClick:self];
}

@end
