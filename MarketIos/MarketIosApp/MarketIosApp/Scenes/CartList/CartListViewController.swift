//
//  CartListViewController.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 22/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import UIKit
import Alamofire

class CartListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "CartListTableViewCell"
    var productList : [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Add product", style: .done, target: self, action: #selector(self.action(sender:)))
    }
    
    @objc func action(sender: UIBarButtonItem) {
        let controller = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "AddProductViewController") as! AddProductViewController
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func closeMarket(){
        let market = Market.init()
        market.id = Session.shared.marketId
//        MarketService.putMarket(market:market).onSuccess { (_, result) in
//
//        }
    }
    
    
    @IBAction func didPressBuy(_ sender: Any) {
        let controller = UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        controller.product = productList
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    //
    //    func getProducts(){
    //        GetProductsListService.getProductss().onSuccess { (_, result) in
    //            if let result = result?.product {
    //                self.productList = result
    //                self.tableView.reloadData()
    //            }
    //        }.onFailure { (_, error) in
    //        }
    //    }
    
}

extension CartListViewController: UITableViewDelegate {
    
}

extension CartListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.productList != nil {
            return self.productList!.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CartListTableViewCell
        let product = self.productList?[indexPath.row]
        cell.lbProduct.text = product?.name
        cell.lbPrice.text = String.init(Double.init(product?.price ?? 0))
        cell.lbClient.text = product?.client
        cell.lbCategory.text = product?.category
        cell.lbQuantity.text = String.init(Double.init(product?.quantity ?? 0))
        cell.lbMarca.text = product?.madeby
        return cell
    }
}

extension CartListViewController: AddProductViewControllerDelegate{
    func didGoBackMagazine(product: [Product]) {
        if self.productList == nil {
            self.productList = []
        }
        for item in product {
            self.productList?.append(item)
        }
        self.tableView.reloadData()
    }
    
    func didGoBack(product:Product){
        if self.productList == nil {
            self.productList = []
        }
        self.productList?.append(product)
        self.tableView.reloadData()
    }
}
extension CartListViewController: PaymentViewControllerDelegate {
    func didGoBack(success: Bool) {
        if success {
            self.productList = []
            self.tableView.reloadData()
        }
    }
    
    
}
