//
//  OpenMarket.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 23/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import Foundation
class MarketService {
    class func postMarket (market : Market) -> NetworkPromise<Establishment> {
        return NetworkPromise { promise in
            do {
                try Network.request(PostMarketProtocol(route: .postMarket(market: market)), promise)
            } catch {
                
            }
            
        }
    }
    
    class func putMarket (market : Market) -> NetworkPromise<Establishment> {
        return NetworkPromise { promise in
            do {
                try Network.request(PostMarketProtocol(route: .putMarket(market: market)), promise)
            } catch {
                
            }
            
        }
    }
}
