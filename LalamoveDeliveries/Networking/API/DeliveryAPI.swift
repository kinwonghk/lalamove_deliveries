//
//  DeliveryAPI.swift
//  LalamoveDeliveries
//
//  Created by KinWong on 1/6/2017.
//  Copyright © 2017 Kin. All rights reserved.
//

import Foundation
import Moya

public enum DeliveryAPI{
    case deliveries(Int)
}

extension DeliveryAPI: TargetType{
    public var baseURL: URL {return URL(string: Constants.ServerConfig.ServerAPIUrl)!}
    public var path: String {
        switch self{
        case .deliveries:
            return "/deliveries"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .deliveries(_):
            return .get
        }
    }
    public var parameters: [String: Any]? {
        switch self {
        case .deliveries(let offset):
            return ["offset":offset]
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    public var task: Task {
        switch self {
        case .deliveries:
            return .request
        }
    }
    public var sampleData: Data {
        switch self {
        case .deliveries:
            return "sampleData".data(using: String.Encoding.utf8)!
        }
    }
}
