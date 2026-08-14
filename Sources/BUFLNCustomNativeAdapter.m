//
//  BUFLNCustomNativeAdapter.m
//
//  GroMore 原生只走 FLN 模板（FLNNativeExpressAd），不支持自渲染。
//

#import "BUFLNCustomNativeAdapter.h"
#import "BUFLNAdBidUtil.h"
#import <FLNAdSDK/FLNNativeExpressAd.h>
#import <FLNAdSDK/FLNNativeExpressAdView.h>

@interface BUFLNCustomNativeAdapter () <FLNNativeExpressAdDelegate>
@property (nonatomic, strong, nullable) FLNNativeExpressAd *expressAdLoader;
@property (nonatomic, copy) NSDictionary *lastLoadParameter;
@end

@implementation BUFLNCustomNativeAdapter

- (BUMMediatedAdStatus)mediatedAdStatusWithExpressView:(UIView *)__unused view {
    if (self.expressAdLoader && [self.expressAdLoader isReady]) {
        return BUMMediatedAdStatusNormal;
    }
    return BUMMediatedAdStatusUnknown;
}

- (BUMMediatedAdStatus)mediatedAdStatusWithMediatedNativeAd:(BUMMediatedNativeAd *)__unused ad {
    return BUMMediatedAdStatusUnknown;
}

- (void)loadNativeAdWithSlotID:(NSString *)slotID andSize:(CGSize)size imageSize:(CGSize)__unused imageSize parameter:(NSDictionary *)parameter {
    if (slotID.length == 0) {
        [self.bridge nativeAd:self didLoadFailWithError:[FLNAdBidUtil errorForEmptySlotID]];
        return;
    }
    self.lastLoadParameter = parameter ?: @{};
    self.expressAdLoader = nil;

    NSInteger count = [parameter[BUMAdLoadingParamNALoadAdCount] integerValue];
    if (count <= 0) {
        count = 1;
    }
    CGFloat width = size.width > 1.0 ? size.width : [UIScreen mainScreen].bounds.size.width;
    self.expressAdLoader = [[FLNNativeExpressAd alloc] initWithPosId:slotID width:width];
    self.expressAdLoader.delegate = self;
    id timeoutVal = parameter[BUMAdLoadingParamSPTolerateTimeout];
    if ([timeoutVal respondsToSelector:@selector(doubleValue)] && [timeoutVal doubleValue] > 0) {
        self.expressAdLoader.timeout = [timeoutVal doubleValue];
    }
    [self.expressAdLoader loadAd:count];
}

- (void)renderForExpressAdView:(UIView *)expressAdView {
    [self.bridge nativeAd:self renderSuccessWithExpressView:expressAdView];
}

- (void)setRootViewController:(UIViewController *)__unused viewController forExpressAdView:(UIView *)__unused expressAdView {
}

- (void)setRootViewController:(UIViewController *)__unused viewController forNativeAd:(id)__unused nativeAd {
}

- (void)registerContainerView:(__kindof UIView *)__unused containerView andClickableViews:(NSArray<__kindof UIView *> *)__unused views forNativeAd:(id)__unused nativeAd {
}

- (void)unregisterClickableViewsForNativeAd:(id)__unused nativeAd {
}

- (void)didReceiveBidResult:(BUMMediaBidResult *)result {
    id target = result.originNativeAdData ?: self.expressAdLoader;
    [FLNAdBidUtil applyMediaBidResult:result adObject:target];
}

#pragma mark - FLNNativeExpressAdDelegate

- (void)nativeExpressAdFailToLoad:(FLNNativeExpressAd *)__unused nativeExpressAd error:(NSError *)error {
    [self.bridge nativeAd:self didLoadFailWithError:error];
}

- (void)nativeExpressAdViewRenderSuccess:(FLNNativeExpressAd *)__unused nativeExpressAd nativeExpressAdView:(NSArray<FLNNativeExpressAdView *> *)nativeExpressAdViews {
    NSMutableArray *exts = [NSMutableArray array];
    for (FLNNativeExpressAdView *view in nativeExpressAdViews) {
        [exts addObject:[FLNAdBidUtil loadExtWithECPM:[view eCPM] parameter:self.lastLoadParameter]];
    }
    [self.bridge nativeAd:self didLoadWithExpressViews:nativeExpressAdViews exts:[exts copy]];
}

- (void)nativeExpressAdViewRenderFail:(FLNNativeExpressAd *)__unused nativeExpressAd error:(NSError *)error {
    [self.bridge nativeAd:self didLoadFailWithError:error];
}

- (void)nativeExpressAdViewDidShow:(FLNNativeExpressAd *)__unused nativeExpressAd nativeExpressAdView:(FLNNativeExpressAdView *)nativeExpressAdView {
    [self.bridge nativeAd:self didVisibleWithMediatedNativeAd:nativeExpressAdView];
}

- (void)nativeExpressAdViewClicked:(FLNNativeExpressAd *)__unused nativeExpressAd nativeExpressAdView:(FLNNativeExpressAdView *)nativeExpressAdView {
    [self.bridge nativeAd:self didClickWithMediatedNativeAd:nativeExpressAdView];
}

- (void)nativeExpressAdViewClosed:(FLNNativeExpressAd *)__unused nativeExpressAd nativeExpressAdView:(FLNNativeExpressAdView *)nativeExpressAdView {
    [self.bridge nativeAd:self didCloseWithExpressView:nativeExpressAdView closeReasons:nil];
}

@end
