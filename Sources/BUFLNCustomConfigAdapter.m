//
//  BUFLNCustomConfigAdapter.m
//

#import "BUFLNCustomConfigAdapter.h"
#import "BUFLNInitHelper.h"
#import <FLNAdSDK/FLNAdSDKManager.h>

@interface BUFLNCustomConfigAdapter ()
@property (nonatomic, strong) NSMutableDictionary *flnInitMetrics;
@end

@implementation BUFLNCustomConfigAdapter

- (instancetype)init {
    if (self = [super init]) {
        _flnInitMetrics = [@{ @"status" : @(NO), @"duration" : @(0) } mutableCopy];
    }
    return self;
}

- (BUMCustomAdapterVersion *)basedOnCustomAdapterVersion {
    return BUMCustomAdapterVersion1_1;
}

- (void)initializeAdapterWithConfiguration:(BUMSdkInitConfig *)initConfig {
    // 只落地 appId；SDK 初始化由各广告 load 前 ensureReadyForAdLoad 完成。
    [BUFLNInitHelper saveAppId:initConfig.appID];
}

- (NSString *)adapterVersion {
    return @"1.0.5";
}

- (NSString *)networkSdkVersion {
    return [FLNAdSDKManager sdkVersion] ?: @"";
}

- (NSMutableDictionary *)adnInitInfo {
    return self.flnInitMetrics;
}

- (void)didRequestAdPrivacyConfigUpdate:(NSDictionary *)__unused config {
}

- (void)didReceiveConfigUpdateRequest:(BUMUserConfig *)__unused config {
}

@end
