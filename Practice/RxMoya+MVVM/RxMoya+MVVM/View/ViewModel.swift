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

class ViewModel: BaseViewModel {
    
    let repositoryDatas = BehaviorRelay<[RepositoryModel]>(value: [])
    
    let provider = MoyaProvider<GithubAPI>()
    func requestRepository(userID: String) -> Single<RepositoryModel> {
        provider.rx.request(.getRepositorByUserID(userID))
            .flatMap { response in
                do {
                    print(response.data)
//                    guard let dictionary = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]
//                    else {
//                        fatalError()
//                    }
                    return .just(try response.map(RepositoryModel.self))
                } catch(let err) {
                    print(err.localizedDescription)
                    fatalError()
                }
            }
    }

    
}
