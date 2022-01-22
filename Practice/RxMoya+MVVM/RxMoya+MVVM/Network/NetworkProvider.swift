//
//  MoyaProvider.swift
//  RxMoya+MVVM
//
//  Created by Wody on 2022/01/22.
//

import Foundation
import Moya

final class NetworkProvider<Target: TargetType>: MoyaProvider<Target> {
    
    init(stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub) {
        super.init(stubClosure: stubClosure)
    }
}
