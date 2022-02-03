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
    func toProductsPageDomain() -> ProductsPage {
        var products = [ProductEntity]()
      
        for product in self.products {
            let imgeEntity = ImageEntity(width: product.image?.width, height: product.image?.height, url: product.image?.url)
            let productEntity = ProductEntity(id: product.id, productDescription: product.productDescription, image: imgeEntity, price: product.price)
            products.append(productEntity)
        }
        
        let productsPage = ProductsPage(products: products)
        return productsPage
    }
}

extension ProductsDTO {
   static func toProductsDomain(entities: [ProductEntity]) -> ProductsDTO {
        var products = [ProductResponseDTO]()

        for product in entities {
            let image = Image(width: product.image?.width ?? 0,
                                              height: product.image?.height ?? 0,
                                              url: product.image?.url ?? "")
            let responseProduct = ProductResponseDTO(id: product.id ?? 0,
                                          productDescription: product.productDescription ?? "",
                                                     image: image, price: product.price ?? 0)
            products.append(responseProduct)
        }
        return ProductsDTO(products: products)
    }
}
