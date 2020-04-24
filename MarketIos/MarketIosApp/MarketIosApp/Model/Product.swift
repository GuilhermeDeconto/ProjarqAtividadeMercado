//
//  Product.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 22/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import Foundation
import ObjectMapper

class Product: NSObject {
    
    override init() {
        self.client = "ds"
        self.category = "ds"
        self.madeby = "ds"
        self.name = "ds"
        self.price = 2.0
        self.quantity = 1
        
    }
    
    var client : String = ""
    var category : String = ""
    var madeby: String = ""
    var name: String = ""
    var price: Double = 0.0
    var quantity: Int = 1
    
    required init?(map: Map) {
        
    }
    
    init(client: String, category: String, madeby: String, name: String, price: Double, quantity: Int) {
        self.name = name
        self.category = category
        self.madeby = madeby
        self.client = client
        self.price = price
        self.quantity = quantity
    }
    
}

extension Product: Mappable {
    func mapping(map: Map) {
        self.client <- map["cliente"]
        self.category <- map["category"]
        self.madeby <- map["madeby"]
        self.name <- map["name"]
        self.price <- map["price"]
        self.quantity <- map["quantity"]
    }
}
extension Product {
static var products: [Product] = [
    Product(client: "Ana", category: "Frutas", madeby: "papaia", name: "Abacate", price: 2.99, quantity: 1),
    Product(client: "Ana", category: "Frutas", madeby: "papaia", name: "Abacaxi", price: 4.99, quantity: 1),
    Product(client: "Ana", category: "Frutas", madeby: "papaia", name: "Butiá", price: 1.99, quantity: 1),
    Product(client: "Ana", category: "Frutas", madeby: "papaia", name: "Cacau", price: 22.99, quantity: 1),
    Product(client: "Ana", category: "Frutas", madeby: "papaia", name: "Figo", price: 3.49, quantity: 1),
    Product(client: "Ana", category: "Frutas", madeby: "papaia", name: "Guaraná", price: 5.78, quantity: 1),
    Product(client: "Ana", category: "Frutas", madeby: "papaia", name: "Jaca", price: 10.28, quantity: 1),
    Product(client: "Ana", category: "Frutas", madeby: "papaia", name: "Limão", price: 7.99, quantity: 1),
    Product(client: "Ana", category: "Frutas", madeby: "papaia", name: "Manga", price: 4.99, quantity: 1),
    Product(client: "Ana", category: "Frutas", madeby: "papaia", name: "Pêra", price: 6.33, quantity: 1),
    Product(client: "Ana", category: "Frutas", madeby: "papaia", name: "Pitomba", price: 3.29, quantity: 1),
    Product(client: "Ana", category: "Frutas", madeby: "papaia", name: "Umbu", price: 9.99, quantity: 1),
    Product(client: "Ana", category: "Frutas", madeby: "papaia", name: "Xixá", price: 0.99, quantity: 1),
    Product(client: "Ana", category: "Carnes", madeby: "CBS", name: "Filé Mingon", price: 18.99, quantity: 1),
    Product(client: "Ana", category: "Carnes", madeby: "CBS", name: "Contra Filé", price: 28.99, quantity: 1),
    Product(client: "Ana", category: "Carnes", madeby: "CBS", name: "Alcatra", price: 38.99, quantity: 1),
    Product(client: "Ana", category: "Carnes", madeby: "CBS", name: "Picanha", price: 58.99, quantity: 1),
    Product(client: "Ana", category: "Carnes", madeby: "CBS", name: "Fraldinha", price: 12.99, quantity: 1),
    Product(client: "Ana", category: "Carnes", madeby: "CBS", name: "Maminha", price: 28.99, quantity: 1),
    Product(client: "Ana", category: "Carnes", madeby: "CBS", name: "Costela", price: 48.99, quantity: 1),
    Product(client: "Ana", category: "Verduras", madeby: "Standard", name: "Berinjela", price: 1.99, quantity: 1),
    Product(client: "Ana", category: "Verduras", madeby: "Standard", name: "Pepino", price: 0.99, quantity: 1),
    Product(client: "Ana", category: "Verduras", madeby: "Standard", name: "Pepino", price: 3.99, quantity: 1),
    Product(client: "Ana", category: "Verduras", madeby: "Standard", name: "Abobrinha", price: 5.99, quantity: 1),
    Product(client: "Ana", category: "Verduras", madeby: "Standard", name: "Cenoura", price: 1.99, quantity: 1),
    Product(client: "Ana", category: "Verduras", madeby: "Standard", name: "Brócolis", price: 4.99, quantity: 1),
    Product(client: "Ana", category: "Verduras", madeby: "Standard", name: "Espinafre", price: 0.99, quantity: 1),
    Product(client: "Ana", category: "Verduras", madeby: "Standard", name: "Rúcula", price: 1.29, quantity: 1),
    Product(client: "Ana", category: "Flores", madeby: "Standard", name: "Rosas", price: 12.29, quantity: 1),
    Product(client: "Ana", category: "Flores", madeby: "Standard", name: "lírio", price: 14.29, quantity: 1),
    Product(client: "Ana", category: "Flores", madeby: "Standard", name: "Orquídea", price: 13.29, quantity: 1),
    Product(client: "Ana", category: "Flores", madeby: "Standard", name: "Margarida", price: 11.29, quantity: 1),
    Product(client: "Ana", category: "Flores", madeby: "Standard", name: "violeta", price: 12.29, quantity: 1),
    Product(client: "Ana", category: "Higiene", madeby: "Gilette", name: "Sabonete", price: 7.29, quantity: 1),
    Product(client: "Ana", category: "Higiene", madeby: "Standard", name: "Desodorante", price: 6.29, quantity: 1),
    Product(client: "Ana", category: "Higiene", madeby: "Standard", name: "Shampoo", price: 9.29, quantity: 1),
    Product(client: "Ana", category: "Higiene", madeby: "Standard", name: "Cotonete", price: 2.29, quantity: 1),
    ]
    
}
