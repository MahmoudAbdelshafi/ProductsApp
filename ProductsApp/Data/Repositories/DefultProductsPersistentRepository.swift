//
//  DefultProductsPersistentRepository.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 01/02/2022.
//

import Foundation

final class DefultProductsPersistentRepository {
    
    private var productsResponseStorage: ProductsResponseStorage
    
    init(productsResponseStorage: ProductsResponseStorage) {
        self.productsResponseStorage = productsResponseStorage
    }
}


extension DefultProductsPersistentRepository: ProductsPersistentRepository {
    
    func fetchRecentsQueries(completion: @escaping (Result<ProductsPage, Error>) -> Void) {
        do {
            productsResponseStorage.getResponse { result in
                switch result {
                case .success(let products):
                    
                    if products.isEmpty {
                        completion(.failure(ErrorType.defaultError))
                    } else {
                        let productsPage = ProductsDTO(products: products).toProductsPageDomain()
                        completion(.success(productsPage))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func saveRecentQuery(products: ProductsPage, completion: @escaping (Result<ProductsPage, Error>) -> Void) {
        let productsDTO = ProductsDTO.toProductEntityDomain(entities: products.products)
        productsResponseStorage.save(response: productsDTO) { result in
            
        }
    }
    
}
