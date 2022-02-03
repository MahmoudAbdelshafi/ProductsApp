//
//  DefultProductsRepository.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//

import Foundation

final class DefultProductsRepository {
    
    private let baseAPI: BaseAPI
    private let cache: ProductsResponseStorage
    
    init(baseAPI: BaseAPI?,
         cache: ProductsResponseStorage) {
        self.baseAPI = baseAPI ?? BaseAPI.sharedInstance
        self.cache = cache
    }
    
    //MARK: - Private
    
    private func retriveFormDataBaseCache(networkError: Error ,completion: @escaping (Result<ProductsPage, Error>) -> Void) {
        self.cache.getResponse { response in
            switch response {
            case .success(let products):
                
                if products.isEmpty {
                    completion(.failure(networkError))
                    return
                }
                let responseDTO = ProductsDTO(products: products).toProductsPageDomain()
                completion(.success(responseDTO))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

extension DefultProductsRepository: ProductsRepository {
    
    func fetchProductsList(completion: @escaping (Result<ProductsPage, Error>) -> Void) {
        baseAPI.request(router: .getProducts) { (result: Result<[ProductResponseDTO], ErrorType>) in
            switch result {
            case .success(let products):
                let responseDTO = ProductsDTO(products: products)
                self.cache.save(response: responseDTO) { _ in }
                completion(.success(responseDTO.toProductsPageDomain()))
            case .failure(let error):
                self.retriveFormDataBaseCache(networkError: error, completion: completion)
            }
        }
    }
}
