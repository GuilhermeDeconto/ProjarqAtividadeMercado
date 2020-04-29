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
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CartListViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem) {
        closeMarket(completion: { (success) -> Void in
            if success {
                _ = self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    
    func closeMarket(completion: @escaping (Bool) -> ()){
        let market = Market.init()
        market.open = false
        MarketService.putMarket(market:market).onSuccess { (_, result) in
            completion(true)
        }.onFailure { (_, error) in
            completion(false)
        }
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
    
    @IBAction func didPressAddItem(_ sender: Any) {
        let controller = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductInfoViewController") as! ProductInfoViewController
        controller.delegate = self
        self.navigationController?.present(controller, animated: true, completion: {
        })
    }
}

extension CartListViewController : ProductInfoViewControllerDelegate {
    func didGoBackFromProductInfo(product: Product){
        if self.productList == nil {
            self.productList = []
        }
        self.productList?.append(product)
        self.tableView.reloadData()
    }
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
        cell.lbQuantity.text = String.init(Double.init(product?.quantity ?? 0))
        return cell
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
