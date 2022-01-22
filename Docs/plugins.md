# Plugins

- Moya 플러긴은 request, response, side-effects들을 커스텀하고 싶을 때 사용합니다. 아래는 이미 Built-in된 plugins에 대해서 입니다.

- authentication, network, activity indicator management, logging 등 일반적으로 쓰이는 함수들에 기본적인 plugin들을 제공합니다.

## Network Activity Indicator

```swift
 private let activity = NetworkActivityPlugin { change, target in
        switch change {
        case .began:
            // Custom Indicator show
        case .ended:
            // Custom Indicator hide
        }
    }
    
lazy var provider = MoyaProvider<GithubAPI>(plugins: [activity])
```

API 호출할 때 Indicator을 시작하고 종료하는 로직을 하나하나 추가해서 쓰는 게 불편하기 때문에 만들어졌습니다. 

1. `NetworkActivityPlugin`을 생성해줍니다.
2. `MoyaProvider`을 생성할 때 plugins에 추가해줍니다.

`change` 는 `NetworkActivityChangeType` enum 타입으로 네트워크가 시작될 때와 끝날 때 두가지 상태를 가지고 있습니다.

`target`은 `TargetType` 프로토콜을 채택한 것으로 `endpoint`들을 구분할 수 있습니다. 이를 이용하여 특정 `endpoint`에는 다른 로딩 액션을 취할 수 있습니다.

👉 [Sources/Moya/Plugins/NetworkActivityPlugin.swift](https://github.com/Moya/Moya/blob/master/Sources/Moya/Plugins/NetworkActivityPlugin.swift)

## Logging 

```swift
struct NetworkLogging: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        // Logging
    }
   func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            guard let urlResponse = response.response else { return }
            // Logging
                case let .failure(error):
            // Logging
        }
    }
}

lazy var provider = MoyaProvider<GithubAPI>(plugins: [NetworkLogging()])
```

개발을 할 때 네트워크 로그를 찍는 일은 꼭 필요하다고는 할 수는 없지만 있으면 굉장히 유용합니다. 하지만 Moya에서 제공해주는 defaut Logging 클래스인 `NetworkLoggerPlugin`는 보기에 불편하기 때문에 커스텀해주면 편합니다. 

1. `PluginType` 프로토콜을 채택 후, `WillSend`와 `didRecieve`함수를 구현해줍니다.
2. 마찬가지로, `MoyaProvider`을 생성할 때 plugins에 추가해줍니다.

👉 [Sources/Moya/Plugins/NetworkLoggerPlugin.swift](https://github.com/Moya/Moya/blob/master/Sources/Moya/Plugins/NetworkLoggerPlugin.swift)
