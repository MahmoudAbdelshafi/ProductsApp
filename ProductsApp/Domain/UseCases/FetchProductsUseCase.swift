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
    private let productsPersistentRepository: ProductsPersistentRepository
    
    //MARK: - Init
    
    init(productsRepository: ProductsRepository,
         productsPersistentRepository: ProductsPersistentRepository) {
        self.productsRepository = productsRepository
        self.productsPersistentRepository = productsPersistentRepository
    }
    
    //MARK: - Methods
    
    func execute(completion: @escaping (Result<ProductsPage, Error>) -> Void) {
        productsRepository.fetchProductsList { result in
            
            switch result {
            case .success(let products):
                /// Cached response into database
                self.productsPersistentRepository.saveRecentQuery(products: products) { _ in }
                completion(.success(products))
                
            case .failure(let networkError):
                self.retriveFormDataBaseRepo(networkError: networkError, completion: completion)
            }
            
        }
    }
    
    private func retriveFormDataBaseRepo(networkError: Error ,completion: @escaping (Result<ProductsPage, Error>) -> Void) {
        self.productsPersistentRepository.fetchRecentsQueries { result in
            switch result {
            case .success(let products):
                completion(.success(products))
                
            case .failure:
                completion(.failure(networkError))
            }
        }
    }
}
