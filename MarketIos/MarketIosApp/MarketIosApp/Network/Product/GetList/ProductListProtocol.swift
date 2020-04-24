//
//  ProductListProtocol.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 22/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import Foundation
import Alamofire

enum ProductRoute {
    case getProducts
}

class ProductProtocol: NSObject, NetworkProtocol {
    
    let route: ProductRoute
    
   var url: String {
        switch route {
        case .getProducts:
            return "product"
        }
    }
    
    var headers: HTTPHeaders?
    
    var httpMethod: HTTPMethod = .get
    
    var parameters: Parameters?
    
    var encoding: ParameterEncoding = URLEncoding.httpBody
    
    var responseType: ResponseType = .object
    
    init(route: ProductRoute) {
        self.route = route
    }
}
