//
//  BaseViewController.swift
//  RxMoya+MVVM
//
//  Created by Wody on 2022/01/20.
//

import UIKit

class BaseViewController<T: BaseViewModel>: UIViewController {
    let viewModel: T
    
    init(_ viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    init?(_ coder: NSCoder, _ viewModel: T) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
}
