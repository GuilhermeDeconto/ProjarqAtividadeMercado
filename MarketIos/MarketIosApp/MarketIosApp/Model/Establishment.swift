//
//  Market.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 23/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import Foundation
import ObjectMapper

class Establishment: NSObject, Mappable {
    
    required init?(map: Map) {
        
    }
    var status : String?
    var message : String?
    var market: Market?
    
    func mapping(map: Map) {
        self.status <- map["status"]
        self.message <- map["message"]
        self.market <- map["market"]
    }
    
}

class Market: NSObject, Mappable {
    
    required init?(map: Map) {
        
    }
    override init() {
        
    }
    var open : Bool?
    var time : String?
    
    func mapping(map: Map) {
        self.open <- map["open"]
        self.time <- map["time"]
    }
}
