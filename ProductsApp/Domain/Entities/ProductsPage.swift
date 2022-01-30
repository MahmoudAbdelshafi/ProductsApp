//
//  ProductsPage.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//

import Foundation

struct ProductsPage {
    let page: Int = 0
    let totalPages: Int = 5
    var products: [ProductEntity]
}

struct ProductEntity {
    var id: Int?
    var productDescription: String?
    var image: ImageEntity?
    var price: Int?
}
