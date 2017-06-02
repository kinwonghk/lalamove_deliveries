//
//  Delivery.swift
//  LalamoveDeliveries
//
//  Created by KinWong on 3/6/2017.
//  Copyright © 2017 Kin. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case missing(String)
}

struct Delivery{
    let description: String
    let imageUrl: String
    let address: String
    let latitude: Double
    let longitude: Double
}

extension Delivery{
    init?(json:[String: Any]) throws {
        guard let description = json["description"] as? String else { throw SerializationError.missing("description")}
        guard let imageUrl = json["imageUrl"] as? String else { throw SerializationError.missing("imageUrl")}
        guard let locationJson = json["location"] as? [String: Any],
            let address = locationJson["address"] as? String,
            let latitude = locationJson["lat"] as? Double,
            let longitude = locationJson["lng"] as? Double else { throw SerializationError.missing("location")}
        
        self.description = description
        self.imageUrl = imageUrl
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
}
