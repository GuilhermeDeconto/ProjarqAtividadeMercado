//
//  GetProductsListService.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 23/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import Foundation
class GetProductsListService {
    class func getProductss () -> NetworkPromise<Products> {
        return NetworkPromise { promise in
            do {
                try Network.request(ProductProtocol(route: .getProducts), promise)
            } catch {
                
            }
            
        }
    }
}
