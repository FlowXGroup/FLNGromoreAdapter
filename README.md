# FLNGromoreAdapter

GroMore 自定义 Adapter。依赖 `FLNAdSDK` Pod，不内含 `FLNAdSDK.xcframework`。

## 要求

- iOS 13.0+
- `FLNAdSDK` 6.2.0.19（主工程 Pod 集成，私有源需显式声明）
- `Ads-CN`（穿山甲 / GroMore，版本由主工程按 GroMore 文档指定）

## 用户接入

在 Podfile 中：

```ruby
platform :ios, '13.0'

pod 'FLNGromoreAdapter',
  :git => 'git@github.com:FlowXGroup/FLNGromoreAdapter.git',
  :tag => '1.0.3'

# FLNAdSDK 私有源必须显式写，否则 CocoaPods 拉不到
pod 'FLNAdSDK',
  :git => 'https://github.com/FlowXGroup/FLNAdSDK-iOS.git',
  :tag => '6.2.0.19'

pod 'Ads-CN', '7.7.0.5', :subspecs => ['BUAdSDK', 'CSJMediation']
```

```bash
pod install
```

用 `.xcworkspace` 打开工程。不要再手拖 `FLNAdSDK.xcframework`。

依赖关系：`FLNGromoreAdapter` → `FLNAdSDK`（版本由 Adapter podspec 锁定为 6.2.0.19）。

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
