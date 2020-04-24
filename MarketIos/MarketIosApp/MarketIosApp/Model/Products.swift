//
//  File.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 22/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import Foundation
import ObjectMapper

class Products: NSObject, Mappable {
    
    required init?(map: Map) {
        
    }
    var status : String?
    var message : String?
    var totalPrice: Double?
    var product: [Product]?
    
    func mapping(map: Map) {
        self.status <- map["status"]
        self.message <- map["message"]
        self.product <- map["product"]
        self.totalPrice <- map["totalPrice"]
    }
    
}
