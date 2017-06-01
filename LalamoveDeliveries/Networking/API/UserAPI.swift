//
//  UserAPI.swift
//  ChillsingTime
//
//  Created by Kin on 1/20/17.
//  Copyright © 2017 Kin. All rights reserved.
//

import Foundation
import Moya

public enum UserAPI{
    case login(String,String)
    case userProfile
}

extension UserAPI: TargetType{
    public var baseURL: URL {return URL(string: Constants.ServerConfig.ServerAPIUrl)!}
    public var path: String {
        switch self{
        case .login(_,_):
            return "/rest/V1/login"
        case .userProfile:
            return "/rest/V1/user"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .login(_, _):
            return .post
        case .userProfile:
            return .get
        }
    }
    public var parameters: [String: Any]? {
        switch self {
        case .login(let loginname, let password):
            return ["loginname": loginname, "password": password]
        case .userProfile:
            return nil
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    public var task: Task {
        switch self {
        case .userProfile:
            return .request
        default:
            return .request
        }
    }
    public var sampleData: Data {
        switch self {
        case .userProfile:
            return "sampleData".data(using: String.Encoding.utf8)!
        default:
            return "sampleData".data(using: String.Encoding.utf8)!
        }
    }
}
