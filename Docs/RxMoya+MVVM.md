# RxMoya + MVVM

🚀 *GithubAPI를 사용했습니다.*

🚀 *RxMoya+MVVM 예제입니다.*



- `GithubAPI.swift`

  TargetType을 채택한 열거체를 만들어줍니다. (repository와 issue를 받아올 경로 2개를 구현해주었습니다.)

```swift

enum GithubAPI {
  case getRepositorByUserID(String)
  case getIssueInOrganization(String)
}

typealias Method = Moya.Method

extension GithubAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://api.github.com")!
  }
  // MARK: - 경로
  var path: String {
    switch self {
    case .getRepositorByUserID(let userID):
      return "/users/\(userID)/repos"
    case .getIssueInOrganization(let organization):
      return "/orgs/\(organization)/issues"
    }
  }
  // MARK: - REST API 형식
  var method: Method {
    switch self {
    case .getRepositorByUserID:
      return .get
    case .getIssueInOrganization:
      return .get
    }
  }
  // MARK: - 데이터
  var task: Task {
    switch self {
    case .getRepositorByUserID:
      return .requestPlain
    case .getIssueInOrganization:
      return .requestPlain
    }
  }
  var headers: [String : String]? {
    [
      "Content-Type": "application/json",
      "Authorization": "" // TODO: 토큰 삽입
    ]
  }
}
```



- `ViewModel.swift`

  `requestRepository`함수를 VC에서 불러서 보이지 않는 `_requestRepository` 함수를 이용해 요청을 받아온 후 `repositoryDatas`에 전달해줍니다. 

```swift

class ViewModel: BaseViewModel {
    let repositoryDatas = BehaviorRelay<[RepositoryModel]>(value: [])
    let provider = MoyaProvider<GithubAPI>() 
    func requestRepository(userID: String) {
        _requestRepository(userID: userID)
            .subscribe(onSuccess: { [weak self] in
                self?.repositoryDatas.accept($0)
            })
            .disposed(by: disposeBag)
    }
    private func _requestRepository(userID: String) -> Single<[RepositoryModel]> {
        return provider.rx.request(.getRepositorByUserID(userID))
            .flatMap { response in
                do {
                    return .just(try response.map([RepositoryModel].self))
                } catch(let err) {
                    print(err.localizedDescription)
                    fatalError()
                }
            }
    }
}
```



- `ViewController.swift`

  tableView의 dataSource는 `repositoryDatas`를 구독해둡니다. repository 요청 버튼을 누르면 위에서 구현하였던 `requestRepository`함수를 이용하여 요청을 보냅니다. `repositoryDatas`가 업데이트가 되면 tableView도 업데이트가 됩니다.

```swift
class ViewController: BaseViewController<ViewModel> {
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var repositoryButton: UIButton!
    @IBOutlet weak var issueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRepositoryButton()
        setupTableView()
    }
    
    private func setupRepositoryButton() {
        repositoryButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.requestRepository(userID: "wody27")
            })
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        viewModel.repositoryDatas
            .bind(to: tableView.rx.items(cellIdentifier: "TableViewCell",
                                         cellType: TableViewCell.self)) { row, cellModel, cell in
                cell.nameLabel.text = cellModel.name
            }.disposed(by: disposeBag)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
}
```



### [+추가](https://github.com/wody27/moya-practice/blob/main/Docs/+more.md)

- ViewController에 ViewModel 주입하기 (+ BaseViewModel, BaseViewController) 

- rx를 이용한 tableView datasource

