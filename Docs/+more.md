# + 추가



### 스토리보드로 생성되는 ViewController에 ViewModel 주입하기 (+ BaseViewModel, BaseViewController)

`istantiateViewController(identifier:creator:)`를 이용하여 원하는 ViewController를 생성해서 return 할 수 있습니다.

```swift
let storyBoard = UIStoryboard(name: "Main", bundle: nil)
let viewController = storyBoard.instantiateViewController(identifier: "ViewController", creator: { coder -> ViewController in
          let viewModel = ViewModel()
          return .init(coder, viewModel) ?? ViewController(ViewModel())
        })
```



### tableView.rx.items(cellIdentifier: String, cellType: Cell.Type) 사용하기 

```swift
viewModel.repositoryDatas
            .bind(to: tableView.rx.items(cellIdentifier: "TableViewCell",
                                         cellType: TableViewCell.self)) { row, cellModel, cell in
                cell.nameLabel.text = cellModel.name
            }.disposed(by: disposeBag)
```



### 참고 

- [[RxSwift] Rx로 TableView를 그리는 4가지 방법 + setDelegate](https://eunjin3786.tistory.com/29)

- [MVVM-환경에서-ViewModel-주입하기](https://velog.io/@dvhuni/MVVM-환경에서-ViewModel-주입하기)