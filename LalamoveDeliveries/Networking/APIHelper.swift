//
//  APIHelper.swift
//  LalamoveDeliveries
//
//  Created by KinWong on 1/6/2017.
//  Copyright © 2017 Kin. All rights reserved.
//

import Foundation
import Moya

class APIHelper{
    class func getDeliveries(offset: Int,completionHandler:@escaping(Bool,String)->()){
        let deliveryProvider = MoyaProvider<DeliveryAPI>()
        deliveryProvider.request(.deliveries(offset)){ result in
            switch result{
            case let .success(response):
                let responseString = try? response.mapString()
                let deliveriesString = responseString ?? ""
                if(!deliveriesString.isEmpty){
                    log.verbose(deliveriesString)
                }
                
                if(response.statusCode == 200){
                    completionHandler(true,deliveriesString)
                }else{
                    log.error("connect success but return fail")
                    completionHandler(false,deliveriesString)
                }
            default:
                log.error("server return fail")
                completionHandler(false,"error")
            }
        }
    }
    
//    class func login(loginname: String, password: String, completionHandler:@escaping(Bool)->()){
//        let userProvider = MoyaProvider<UserAPI>();
//        userProvider.request(.userProfile){ result in
//            switch result{
//            case let .success(response):
//                log.debug("statusCode \(response.statusCode)")
//                if(response.statusCode == 200){ // Server response login success
//                    let responseString = try? response.mapString()
//                    var token = responseString ?? ""
//                    if(!token.isEmpty){
//                        log.debug("token \(token)")
//                        token = token.replacingOccurrences(of: "\"", with: "")
//                        completionHandler(true);
//                    }else{
//                        log.error("No token found from server response")
//                        completionHandler(false);
//                    }
//                }else{ // Server response login fail
//                    log.error("Server respon: \(response.mapString)")
//                    completionHandler(false)
//                }
//            default:
//                log.error("Login fail");
//                completionHandler(false)
//            }
//        }
//    }
}
