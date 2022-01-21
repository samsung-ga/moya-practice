//
//  GithubAPI.swift
//  RxMoya+MVVM
//
//  Created by Wody on 2022/01/19.
//

import Foundation
import Moya

enum GithubAPI {
  case getRepositorByUserID(String)
  case getIssueInOrganization(String)
}

extension GithubAPI: TargetType {
  // MARK: - 경로
  var path: String {
    switch self {
    case .getRepositorByUserID(let userID):
      return "/users/\(userID)/repos"
    case .getIssueInOrganization(let organization):
      return "/orgs/\(organization)/issues"
    }
  }
  // MARK: - REST API 형식
  var method: Method {
    switch self {
    case .getRepositorByUserID:
      return .get
    case .getIssueInOrganization:
      return .get
    }
  }
  // MARK: - 데이터
  var task: Task {
    switch self {
    case .getRepositorByUserID:
      return .requestPlain
    case .getIssueInOrganization:
      return .requestPlain
    }
  }
}
