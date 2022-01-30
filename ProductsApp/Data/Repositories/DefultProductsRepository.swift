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
    
    init(baseAPI: BaseAPI?, cache: ProductsResponseStorage) {
        self.baseAPI = baseAPI ?? BaseAPI.sharedInstance
        self.cache = cache
    }
}

extension DefultProductsRepository: ProductsRepository {
    func fetchProductsList(completion: @escaping (Result<ProductsPage, Error>) -> Void) {
        
        baseAPI.request(router: .getProducts) { (result: Result<[ProductResponseDTO], ErrorType>) in
            ///Manage caching
            let DTO = ProductResponseDTO()
            self.cache.getResponse(for: DTO) { result in

//                if case let .success(responseDTO?) = result {
//                    //cached(responseDTO.toDomain())
//                }
            }
            switch result {
            case .success(let products):
                let responseDTO = ProductsDTO(products: products).toDomain()
                completion(.success(responseDTO))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
