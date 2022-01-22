//
//  ViewController.swift
//  RxMoya+MVVM
//
//  Created by Wody on 2022/01/19.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: BaseViewController<ViewModel> {
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var repositoryButton: UIButton!
    @IBOutlet weak var issueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRepositoryButton()
        seupTableView()
    }
    
    private func setupRepositoryButton() {
        repositoryButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.requestRepository(userID: "wody27")
            })
            .disposed(by: disposeBag)
    }
    
    private func seupTableView() {
        viewModel.repositoryDatas
            .bind(to: tableView.rx.items(cellIdentifier: "TableViewCell",
                                         cellType: TableViewCell.self)) { row, cellModel, cell in
                cell.nameLabel.text = cellModel.name
            }.disposed(by: disposeBag)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
   
}

extension ViewController: UITableViewDelegate {
    
}
