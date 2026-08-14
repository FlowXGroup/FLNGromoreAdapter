//
//  FLNErrorCodeHeader.h
//  FLNAdSDK
//
//  Created by lee on 2025/12/17.
//

#ifndef FLNErrorCodeHeader_h
#define FLNErrorCodeHeader_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 对外 `NSError.domain`，一般为该值。
FOUNDATION_EXPORT NSString * const kFLNErrorDomain;

/**
 FlowNet SDK 对外错误码（分段编号）。
 error.domain 一般为 kFLNErrorDomain；
 code 在 1000~5999 为 SDK 自有码，其它值可能为服务端业务码。
 */
typedef NS_ENUM(NSInteger, FLNErrorCode) {

    // MARK: - 1xxx 客户端 / 状态

    /// 入参非法（缺 posId/appId、非法 window/VC 等）。
    FLNErrorCodeInvalidParameter = 1001,
    /// 重复发起加载。
    FLNErrorCodeDuplicateRequest = 1002,
    /// 广告已失效（缓存过期 / 已曝光消费，`isReady`/`isAdValid` 为 NO）。
    FLNErrorCodeAdExpired = 1003,
    /// 广告未 ready（未加载成功或当前无可展示物料）。
    FLNErrorCodeAdNotReady = 1004,

    // MARK: - 2xxx 初始化

    /// SDK 初始化失败（startWithConfig: 失败时统一返回）。
    FLNErrorCodeInitFailed = 2001,

    // MARK: - 3xxx 加载

    /// 无填充。
    FLNErrorCodeAdNoFill = 3001,
    /// 加载超时。
    FLNErrorCodeAdTimeout = 3002,
    /// 网络错误（无网、DNS、连接失败、HTTP 传输失败等；非超时）。
    FLNErrorCodeAdNetworkError = 3003,
    /// 加载失败兜底（解析失败等无法归入 3001/3002/3003）。
    FLNErrorCodeAdLoadFailed = 3004,

    // MARK: - 4xxx 素材

    /// 视频素材加载/准备失败。
    FLNErrorCodeVideoLoadFailed = 4001,
    /// 图片素材加载失败。
    FLNErrorCodeImageLoadFailed = 4002,
    /// 模板/创意渲染失败。
    FLNErrorCodeCreativeRenderFailed = 4003,

    // MARK: - 5xxx 展示

    /// 视频播放失败。
    FLNErrorCodeVideoPlaybackFailed = 5001,
    /// 落地页 URL 无效。
    FLNErrorCodeWebViewInvalidURL = 5002,
    /// 曝光未达阈值。
    FLNErrorCodeExposureInsufficient = 5003,
    /// 展示失败兜底。
    FLNErrorCodeAdShowFailed = 5004,

};

NS_ASSUME_NONNULL_END

#endif /* FLNErrorCodeHeader_h */
