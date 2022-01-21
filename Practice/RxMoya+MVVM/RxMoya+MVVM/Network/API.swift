//
//  API.swift
//  RxMoya+MVVM
//
//  Created by Wody on 2022/01/19.
//

import Foundation
import Moya

enum API {
  case mock
}

extension TargetType {
  var baseURL: URL {
    return URL(string: "https://api.github.com")!
  }
  
  var headers: [String : String]? {
    [
      "Content-Type": "application/json",
      "Authorization": "" // TODO: 토큰 삽입
    ]
  }
}
