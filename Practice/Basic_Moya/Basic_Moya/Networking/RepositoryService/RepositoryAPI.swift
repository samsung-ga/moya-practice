//
//  GithubAPI.swift
//  Basic_Moya
//
//  Created by Wody on 2022/01/18.
//

import Foundation
import Moya

enum RepositoryAPI {
  case repository(String)
}

extension RepositoryAPI: TargetType {
  
  var baseURL: URL {
    return URL(string: "https://api.github.com")!
  }
  
  // MARK: - 경로
  var path: String {
    switch self {
    case .repository(let userID):
      return "/users/\(userID)/repos"
    }
  }
  // MARK: - HTTP형식
  var method: Moya.Method {
    switch self {
    case .repository:
      return .get
    }
  }
  // MARK: - 데이터
  var task: Task {
    switch self {
    case .repository:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    // TODO: 필요 시, 토큰 추가
    // "Authorization": ""
    [
      "Content-Type": "application/json"
    ]
    
  }
  
}
