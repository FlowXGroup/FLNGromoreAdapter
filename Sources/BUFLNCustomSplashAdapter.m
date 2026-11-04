//
//  BUFLNCustomSplashAdapter.m
//

#import "BUFLNCustomSplashAdapter.h"
#import "BUFLNAdBidUtil.h"
#import "BUFLNInitHelper.h"
#import <FLNAdSDK/FLNSplashAd.h>

@interface BUFLNCustomSplashAdapter () <FLNSplashAdDelegate>
@property (nonatomic, strong, nullable) FLNSplashAd *splashAd;
@property (nonatomic, weak, nullable) UIView *customBottomView;
@property (nonatomic, copy) NSDictionary *lastLoadParameter;
@end

@implementation BUFLNCustomSplashAdapter

- (BUMMediatedAdStatus)mediatedAdStatus {
    if (self.splashAd && [self.splashAd isReady]) {
        return BUMMediatedAdStatusNormal;
    }
    return BUMMediatedAdStatusUnknown;
}

- (void)loadSplashAdWithSlotID:(NSString *)slotID andParameter:(NSDictionary *)parameter {
    self.lastLoadParameter = parameter ?: @{};
    self.customBottomView = parameter[BUMAdLoadingParamSPCustomBottomView];

    __weak typeof(self) weakSelf = self;
    [BUFLNInitHelper ensureReadyForAdLoad:^(BOOL success, NSError * _Nullable error) {
        __strong typeof(weakSelf) self = weakSelf;
        if (!self) {
            return;
        }
        if (!success) {
            [self.bridge splashAd:self didLoadFailWithError:error ext:@{}];
            return;
        }
        self.splashAd = [[FLNSplashAd alloc] initWithPosId:slotID];
        self.splashAd.delegate = self;
        id timeoutVal = parameter[BUMAdLoadingParamSPTolerateTimeout];
        if ([timeoutVal respondsToSelector:@selector(doubleValue)]) {
            NSTimeInterval t = [timeoutVal doubleValue];
            if (t > 0) {
                self.splashAd.timeout = t;
            }
        }
        [self.splashAd loadAd];
    }];
}

- (void)showSplashAdInWindow:(UIWindow *)window parameter:(NSDictionary *)__unused parameter {
    if (!window || !self.splashAd || ![self.splashAd isReady]) {
        return;
    }
    [self.splashAd showAdInWindow:window withBottomView:self.customBottomView];
}

- (void)dismissSplashAd {
    self.customBottomView = nil;
    self.splashAd = nil;
}

- (void)didReceiveBidResult:(BUMMediaBidResult *)result {
    [FLNAdBidUtil applyMediaBidResult:result adObject:self.splashAd];
}

#pragma mark - FLNSplashAdDelegate

- (void)splashAdDidLoad:(FLNSplashAd *)splashAd {
    NSDictionary *ext = [FLNAdBidUtil loadExtWithECPM:[splashAd eCPM] parameter:self.lastLoadParameter];
    [self.bridge splashAd:self didLoadWithExt:ext];
}

- (void)splashAdLoadFail:(FLNSplashAd *)__unused splashAd error:(NSError *)error {
    [self.bridge splashAd:self didLoadFailWithError:error ext:@{}];
}

- (void)splashAdDidShow:(FLNSplashAd *)__unused splashAd {
    [self.bridge splashAdWillVisible:self];
}

- (void)splashAdShowFailed:(FLNSplashAd *)__unused splashAd withError:(NSError *)error {
    [self.bridge splashAdDidShowFailed:self error:error];
}

- (void)splashAdClicked:(FLNSplashAd *)__unused splashAd {
    [self.bridge splashAdDidClick:self];
}

- (void)splashAdClosed:(FLNSplashAd *)__unused splashAd {
    [self.bridge splashAdDidClose:self];
    self.customBottomView = nil;
    self.splashAd = nil;
}

- (void)splashAdSkip:(FLNSplashAd *)__unused splashAd time:(NSInteger)__unused time {
    [self.bridge splashAdDidClickSkip:self];
}

@end
