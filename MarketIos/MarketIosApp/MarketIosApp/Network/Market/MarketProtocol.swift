//
//  MarketProtocol.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 23/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

enum PostMarketRoute {
    case postMarket(market: Market)
    case putMarket(marketId: String, market : Market)
}

class PostMarketProtocol: NSObject, NetworkProtocol {
    
    let route: PostMarketRoute
    
    var url: String {
        switch route {
        case .postMarket:
            return "market"
        case .putMarket(let marketId, _):
            return "market/\(marketId)"
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var httpMethod: HTTPMethod {
        switch route {
        case .postMarket:
            return HTTPMethod.post
        case .putMarket:
            return HTTPMethod.put
        }
    }
    
    var parameters: Parameters? {
        var parameters: [String: Any] = [:]
        switch route {
        case let .postMarket(market):
            parameters["market"] = Mapper<Market>().toJSON(market)
        case let .putMarket(_, market):
            parameters["market"] = Mapper<Market>().toJSON(market)
        default:
            break
        }
        
        return parameters
    }
    
    var encoding: ParameterEncoding = JSONEncoding.default
    
    var responseType: ResponseType = .object
    
    init(route: PostMarketRoute) {
        self.route = route
    }
}
