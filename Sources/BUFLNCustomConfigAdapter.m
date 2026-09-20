//
//  BUFLNCustomConfigAdapter.m
//

#import "BUFLNCustomConfigAdapter.h"
#import <FLNAdSDK/FLNAdSDKManager.h>
#import <FLNAdSDK/FLNInitConfig.h>

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
    FLNInitConfig *cfg = [[FLNInitConfig alloc] init];
    cfg.appId = initConfig.appID ?: @"";
    cfg.userId = @"";
    CFAbsoluteTime t0 = CFAbsoluteTimeGetCurrent();
    __weak typeof(self) weakSelf = self;
    [[FLNAdSDKManager sharedInstance] startWithConfig:cfg completionHandler:^(BOOL success, NSError *_Nullable __unused error) {
        __strong typeof(weakSelf) self = weakSelf;
        if (!self) {
            return;
        }
        NSInteger ms = (NSInteger)((CFAbsoluteTimeGetCurrent() - t0) * 1000.0);
        self.flnInitMetrics[@"status"] = @(success);
        self.flnInitMetrics[@"duration"] = @(ms);
    }];
}

- (NSString *)adapterVersion {
    return @"1.0.3";
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
