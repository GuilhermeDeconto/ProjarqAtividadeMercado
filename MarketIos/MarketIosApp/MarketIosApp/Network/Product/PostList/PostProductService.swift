//
//  PostProductService.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 23/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import Foundation
class PostProductService {
    class func postProducts (product : [Product]) -> NetworkPromise<Products> {
        return NetworkPromise { promise in
            do {
                try Network.request(PostProductProtocol(route: .postProducts(product: product)), promise)
            } catch {
                
            }
            
        }
    }
}
