//
//  NetworkLoggin.swift
//  RxMoya+MVVM
//
//  Created by Wody on 2022/01/22.
//

import Foundation
import Moya

struct NetworkLogging: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        #if DEBUG
        guard let urlRequest = request.request else { return }
        print(urlRequest)
        // 더 세세하게 나열
        #endif
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        #if DEBUG
        switch result {
        case let .success(response):
            print("성공")
            // 더 세세하게 나열
        case let .failure(error):
            print("실패")
            // 더 세세하게 나열
        }
        #endif
    }
}
