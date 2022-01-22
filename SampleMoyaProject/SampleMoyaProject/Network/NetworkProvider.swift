//
//  NetworkProvider.swift
//  SampleMoyaProject
//
//  Created by Wody on 2022/01/22.
//

import Foundation
import Moya
import RxMoya
import RxSwift

final class NetworkProvider<Target: TargetType>: MoyaProvider<Target> {
    private let activity = NetworkActivityPlugin { change, target in
        switch change {
        case .began:
            // Start Loading
            break
        case .ended:
            // End Loading
            break
        }
    }
    
    private let logging = NetworkLogging()
    
    init(stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub) {
        super.init(stubClosure: stubClosure,
                   session: DefaultAlamofireSeesion.shared,
                   plugins: [activity, logging])
    }
    
    func requestImmediate<T: Decodable>(_ token: Target) -> Single<T> {
        self.rx.request(token)
            .filterSuccessfulStatusCodes()
            .flatMap { response in
            do {
                return .just(try response.map(T.self))
            } catch let error {
                return .error(error)
            }
        }
    }
    
}
