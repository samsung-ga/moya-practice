//
//  ViewModel.swift
//  RxMoya+MVVM
//
//  Created by Wody on 2022/01/19.
//

import Foundation
import Moya
import RxMoya
import RxSwift
import RxRelay
import UIKit

class ViewModel: BaseViewModel {
    
    let repositoryDatas = BehaviorRelay<[RepositoryModel]>(value: [])
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var activity = NetworkActivityPlugin { change, target in
        print(target)
        switch change {
        case .began:
            // Custom Indicator show
            break
//            indicator.startAnimating()
        case .ended:
//             Custom Indicator hide
//            indicator.stopAnimating()
            break
        }
    }
    
    lazy var provider = MoyaProvider<GithubAPI>(session: DSesssion()) //(plugins: [activity, NetworkLogging()])
    
    func requestRepository(userID: String) {
        _requestRepository(userID: userID)
            .subscribe(onSuccess: { [weak self] in
                self?.repositoryDatas.accept($0)
            })
            .disposed(by: disposeBag)
    }
    
    private func _requestRepository(userID: String) -> Single<[RepositoryModel]> {
        return provider.rx.request(.getRepositorByUserID(userID))
            .debug()
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