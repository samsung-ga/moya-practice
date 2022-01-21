//
//  ViewController.swift
//  RxMoya+MVVM
//
//  Created by Wody on 2022/01/19.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

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
        
    }
    
    private func seupTableView() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        viewModel.repositoryDatas
            .bind(to: tableView.rx.items(cellIdentifier: "TableViewCell",
                                         cellType: TableViewCell.self)) { row, cellModel, cell in
                
            }.disposed(by: disposeBag)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
}

extension ViewController: UITableViewDelegate {
    
}
