//
//  ViewController.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 22/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func goToList(_ sender: Any) {
        let market = Market.init()
        market.open = true
        MarketService.postMarket(market: market).onSuccess { (_, result) in
            if let result = result?.market {
                Session.shared.marketId = result.id ?? ""
            }
//            HUD.flash(.label("Início das atividades"), delay: 1.0){ finished in
                let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartListViewController") as! CartListViewController
                self.navigationController?.pushViewController(controller, animated: true)
//            }
        }.onFailure { (_, error) in
            
        }
        
    }
    
}
