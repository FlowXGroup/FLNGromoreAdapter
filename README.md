# FLNGromoreAdapter

GroMore 自定义 Adapter，已内含 `FLNAdSDK.xcframework`。

## 要求

- iOS 13.0+
- 内含 `FLNAdSDK` 6.2.0.17
- `Ads-CN`（穿山甲 / GroMore，版本由主工程 Podfile 指定，需与 GroMore 接入文档一致）

## 接入

```ruby
platform :ios, '13.0'

pod 'FLNGromoreAdapter',
  :git => 'git@github.com:FlowXGroup/FLNGromoreAdapter.git',
  :tag => '1.0.1'

pod 'Ads-CN', :subspecs => ['BUAdSDK', 'CSJMediation']
```

```bash
pod install
```

主工程无需再单独拖入 / pod `FLNAdSDK`。

## GroMore 控制台类名

| 用途 | 类名 |
|------|------|
| 初始化 | `BUFLNCustomConfigAdapter` |
| 开屏 | `BUFLNCustomSplashAdapter` |
| 激励视频 | `BUFLNCustomRewardedVideoAdapter` |
| 插屏 | `BUFLNCustomInterstitialAdapter` |
| 原生 | `BUFLNCustomNativeAdapter` |

初始化使用 GroMore 下发的 `initConfig.appID` 作为 FLN `appId`。广告位 ID 对应 FLN `posId`。

原生只走 FLN 模板渲染（`FLNNativeExpressAd`），不支持自渲染。
