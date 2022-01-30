//
//  FetchProductsUseCase.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//

import Foundation

protocol FetchProductsUseCase {
    func execute(completion: @escaping (Result<ProductsPage, Error>) -> Void)
}

final class DefaultFetchTopStoriesUseCase: FetchProductsUseCase {
    
    //MARK: - Properties
    
    private let productsRepository: ProductsRepository
    
    //MARK: - Init
    
    init(productsRepository: ProductsRepository) {
        self.productsRepository = productsRepository
    }
    
    //MARK: - Methods
    
    func execute(completion: @escaping (Result<ProductsPage, Error>) -> Void) {
         productsRepository.fetchProductsList { result in
            if case .success = result {
                /// Cached response into database
            }
            
            completion(result)

        }
    }
}
