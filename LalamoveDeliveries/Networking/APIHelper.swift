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
                if(response.statusCode == 200){
                    completionHandler(true,deliveriesString)
                }else{
                    log.error("connect success server return fail")
                    completionHandler(false,deliveriesString)
                }
            default:
                log.error("server return fail")
                completionHandler(false,"error")
            }
        }
    }
}
