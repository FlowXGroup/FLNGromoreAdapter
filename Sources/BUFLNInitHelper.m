//
//  BUFLNInitHelper.m
//

#import "BUFLNInitHelper.h"
#import <FLNAdSDK/FLNAdSDKManager.h>
#import <FLNAdSDK/FLNInitConfig.h>

static NSString * const kBUFLNSavedAppIdKey = @"BUFLN_SavedAppId";
static NSString * const kBUFLNFallbackAppId = @"60021lz5bf";

@implementation BUFLNInitHelper

static BOOL sInitSucceeded = NO;
static BOOL sInitInFlight = NO;
static NSMutableArray<void (^)(BOOL, NSError *)> *sWaiters;

+ (void)saveAppId:(NSString *)appId {
    if (appId.length == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:appId forKey:kBUFLNSavedAppIdKey];
}

+ (NSString *)resolvedAppId {
    NSString *saved = [[NSUserDefaults standardUserDefaults] stringForKey:kBUFLNSavedAppIdKey];
    return saved.length > 0 ? saved : kBUFLNFallbackAppId;
}

+ (void)ensureReadyForAdLoad:(void (^)(BOOL, NSError * _Nullable))completion {
    if (!completion) {
        return;
    }
    BOOL alreadyReady = NO;
    BOOL shouldStart = NO;
    @synchronized (self) {
        if (sInitSucceeded) {
            alreadyReady = YES;
        } else {
            if (!sWaiters) {
                sWaiters = [NSMutableArray array];
            }
            [sWaiters addObject:[completion copy]];
            if (!sInitInFlight) {
                sInitInFlight = YES;
                shouldStart = YES;
            }
        }
    }
    if (alreadyReady) {
        completion(YES, nil);
        return;
    }
    if (!shouldStart) {
        return;
    }

    FLNInitConfig *cfg = [[FLNInitConfig alloc] init];
    cfg.appId = [self resolvedAppId];
    cfg.userId = @"";

    [[FLNAdSDKManager sharedInstance] startWithConfig:cfg
                                    completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSArray *waiters = nil;
        @synchronized (self) {
            sInitInFlight = NO;
            if (success) {
                sInitSucceeded = YES;
            }
            waiters = [sWaiters copy];
            [sWaiters removeAllObjects];
        }
        for (void (^block)(BOOL, NSError *) in waiters) {
            block(success, error);
        }
    }];
}

@end
