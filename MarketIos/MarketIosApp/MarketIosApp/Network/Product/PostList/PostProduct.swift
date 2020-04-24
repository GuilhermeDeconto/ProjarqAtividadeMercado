//
//  PostProduct.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 23/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

enum PostProductRoute {
    case postProducts(product: [Product])
}

class PostProductProtocol: NSObject, NetworkProtocol {
    
    let route: PostProductRoute
    
   var url: String {
        switch route {
        case .postProducts:
            return "productArray"
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var httpMethod: HTTPMethod = .post
    
    var parameters: Parameters? {
        var parameters: [String: Any] = [:]
        switch route {
        case let .postProducts(product):
            parameters["produtos"] = Mapper<Product>().toJSONArray(Array(product))
        default:
            break
        }
        
        return parameters
    }
    
    var encoding: ParameterEncoding = JSONEncoding.default
//    URLEncoding.httpBody
//    JSONEncoding.default
    
    var responseType: ResponseType = .object
    
    init(route: PostProductRoute) {
        self.route = route
    }
}
