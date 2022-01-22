//
//  Session.swift
//  RxMoya+MVVM
//
//  Created by Wody on 2022/01/22.
//

import Foundation
import Moya

class DSesssion: Session {
    static let shared: DSesssion = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest  = 30
        configuration.timeoutIntervalForResource = 30
        configuration.requestCachePolicy         = .useProtocolCachePolicy
        return DSesssion(configuration: configuration)
    }()
}
