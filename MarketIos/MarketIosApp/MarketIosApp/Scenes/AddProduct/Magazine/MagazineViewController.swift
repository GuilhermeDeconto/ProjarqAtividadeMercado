//
//  MagazineViewController.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 23/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import UIKit

protocol MagazineViewControllerDelegate {
    func didGoBack(product: [Product])
}

class MagazineViewController: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellIdentifier = "MagazineTableViewCell"
    
    var category: String?
    
    var selectedItems: [Product]? = []
    
    var productList: [Product]? = []
    var products: [Product]? = []
    
    var delegate: MagazineViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        lbTitle.text = self.category
        
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        self.products = Product.products
        self.productList = products?.filter{products in products.category == self.category}
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.didGoBack(product: self.selectedItems ?? [])
    }
    
}
extension MagazineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.productList != nil {
            return self.productList!.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MagazineTableViewCell
        let product = productList?[indexPath.row]
        cell.lbProductName.text = product?.name
        cell.lbPrice.text = "R$: \(String.init(Double.init(product?.price ?? 0.0)))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedItems?.append(productList?[indexPath.row] ?? Product.init())
    }
    
    
}
extension MagazineViewController: UITableViewDelegate {
    
}
