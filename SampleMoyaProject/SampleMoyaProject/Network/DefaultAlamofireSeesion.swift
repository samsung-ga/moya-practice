//
//  DefaultSession.swift
//  SampleMoyaProject
//
//  Created by Wody on 2022/01/22.
//

import Foundation
import Alamofire

class DefaultAlamofireSeesion: Session {
    static let shared: DefaultAlamofireSeesion = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest  = 10
        configuration.timeoutIntervalForResource = 30
        configuration.requestCachePolicy         = .useProtocolCachePolicy
        return DefaultAlamofireSeesion(configuration: configuration)
    }()
}
