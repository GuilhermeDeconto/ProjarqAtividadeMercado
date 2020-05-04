//
//  ProductInfoViewController.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 27/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import UIKit
import Foundation

protocol ProductInfoViewControllerDelegate {
    func didGoBackFromProductInfo(product: Product)
}

class ProductInfoViewController: UIViewController {
    
    @IBOutlet weak var lbPrice: UITextField!
    @IBOutlet weak var lbName: UITextField!
    var product: Product = Product.init()
    
    var delegate: ProductInfoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    @IBAction func didPressCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            
        })
    }
    
    @IBAction func didPressContinue(_ sender: Any) {
        self.product.name = self.lbName.text ?? "Abacate"
        self.product.price = Double.init(String.init(self.lbPrice.text ?? "")) ?? 0.0
        self.product.category = "APP"
        self.product.client = "Ana"
        self.product.madeby = "Seara"
        self.product.quantity = 1
        if self.lbName.text != nil && self.lbPrice.text != nil {
            dismiss(animated: true) {
                self.delegate?.didGoBackFromProductInfo(product: self.product)
            }
        }
    }
}
