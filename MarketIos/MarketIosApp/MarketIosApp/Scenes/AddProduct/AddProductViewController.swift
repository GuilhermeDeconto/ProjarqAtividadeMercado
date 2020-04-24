//
//  AddProductViewController.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 23/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import UIKit
import PKHUD
protocol AddProductViewControllerDelegate {
    func didGoBack(product: Product)
}

class AddProductViewController: UIViewController {
    
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbQuantity: UILabel!
    @IBOutlet weak var lbProduct: UILabel!
    @IBOutlet weak var lbClient: UILabel!
    @IBOutlet weak var lbMadeby: UILabel!
    
    @IBOutlet weak var etCategory: UITextField!
    @IBOutlet weak var etMadeby: UITextField!
    @IBOutlet weak var etPrice: UITextField!
    @IBOutlet weak var etQuantity: UITextField!
    @IBOutlet weak var etProduct: UITextField!
    @IBOutlet weak var etClient: UITextField!
    
    var delegate: AddProductViewControllerDelegate?
    var product: Product?
    var products: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @IBAction func goToMagazine(_ sender: Any) {
        let controller = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "MagazinePageViewController")
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func addProductInCostumerCart(_ sender: Any) {
        product = Product.init()
        product?.price = Double.init(String.init(etPrice.text ?? "")) ?? 0.0
        product?.madeby = etMadeby.text ?? ""
        product?.name = etProduct.text ?? ""
        product?.client = etClient.text ?? ""
        product?.quantity = Int.init(String.init(etQuantity.text ?? "")) ?? 0
        product?.category = etCategory.text ?? ""
        product?.madeby = etMadeby.text ?? ""
        
        HUD.flash(.label("Produto adicionado ao carrinho"), delay: 0.5){ finished in
            self.navigationController?.popViewController(animated: true)
            self.delegate?.didGoBack(product: self.product!)
        }
    }
}
extension AddProductViewController : MagazineViewControllerDelegate{
    func didGoBack(product: [Product]){
        self.products = product
    }
}
