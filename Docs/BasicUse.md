# 기본적으로 사용해보기

🚀 *Github API를 사용했습니다.*

🚀 *Basic_Moya 예제입니다.*

- 네트워킹을 담당할 열거체를 만들고 `TargetType` 프로토콜을 채택시켜 필요한 속성들을 추가합니다.

```swift
enum RepositoryAPI {
  case repository(String)
}

extension RepositoryAPI: TargetType {
  
  var baseURL: URL {
    return URL(string: "https://api.github.com")!
  }
  
  // MARK: - 경로
  var path: String {
    switch self {
    case .repository(let userID):
      return "/users/\(userID)/repos"
    }
  }
  // MARK: - HTTP형식
  var method: Moya.Method {
    switch self {
    case .repository:
      return .get
    }
  }
  // MARK: - 데이터
  var task: Task {
    switch self {
    case .repository:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    // TODO: 필요 시, 토큰 추가
    // "Authorization": ""
    [
      "Content-Type": "application/json"
    ]
    
  }
}
```

- 네트워크에 사용할 모델을 만들어줍니다.

```swift
struct RepositoryModel: Decodable {
  let id: Int
  let name: String 
}
```


- VC에서 `TargetType`을 제네릭타입으로 가진  `MoyaProvider` 를 생성해주고 열거체 중 하나로 request를 요청해줍니다.

```swift
final class ViewController: UIViewController {
  // ... 일부 코드 생략   
  private let repositoryProvider = MoyaProvider<RepositoryAPI>()
  
  func fetchRepository(with userID: String) {
    repositoryProvider.request(.repository(userID)) { [weak self] result in
      self?.loading.stopAnimating()
      switch result {
      case .success(let response):
        do {
          let decoded = try JSONDecoder().decode([RepositoryModel].self, from: response.data)
          self?.repositories = decoded
          self?.tableView.reloadData()
        } catch(let error) {
          print(error.localizedDescription)
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  // ... 일부 코드 생략   
}
```

