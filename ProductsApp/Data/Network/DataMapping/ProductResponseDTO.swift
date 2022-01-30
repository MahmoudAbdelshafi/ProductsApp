//
//  ProductsResponseDTO.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 29/01/2022.
//

import Foundation

struct ProductResponseDTO: Decodable {
    var id: Int?
    var productDescription: String?
    var image: Image?
    var price: Int?
}

struct Image: Decodable, Equatable {
    var width, height: Int?
    var url: String?
}


struct ProductsDTO {
    let products :[ProductResponseDTO]
}

// MARK: - Mappings to Domain

extension ProductsDTO {
    func toDomain() -> ProductsPage {
        var products = [ProductEntity]()
      
        for i in self.products {
            let imgeEntity = ImageEntity(width: i.image?.width, height: i.image?.height, url: i.image?.url)
            let productEntity = ProductEntity(id: i.id, productDescription: i.productDescription, image: imgeEntity, price: i.price)
            products.append(productEntity)
        }
        
        let productsPage = ProductsPage(products: products)
        return productsPage
    }
}
