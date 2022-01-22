//
//  NetworkManager.swift
//  SampleMoyaProject
//
//  Created by Wody on 2022/01/22.
//

import Foundation
import Moya
import RxSwift

class NetworkManager {
    static func request<T: Decodable, U: TargetType>(provider: NetworkProvider<U> = NetworkProvider(stubClosure: MoyaProvider.neverStub), _ token: U) -> Single<T> {
        return Single<T>.create { single in
            let request = provider.request(token) { result in
                switch result {
                case .success(let response):
                    do {
                        // TODO: 네트워크 오류 처리
                        single(.success(try response.map(T.self)))
                    } catch let error {
                        single(.failure(error))
                    }
                case .failure(let error):
                    // TODO: 네트워크 오류 처리
                    single(.failure(error))
                }
            }
            return Disposables.create { request.cancel() }
        }

    }
}
