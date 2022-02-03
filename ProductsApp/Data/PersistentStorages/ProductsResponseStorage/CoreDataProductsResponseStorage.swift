//
//  CoreDataProductsResponseStorage.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 30/01/2022.
//

import Foundation
import CoreData

final class CoreDataProductsResponseStorage {
    
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
}

extension CoreDataProductsResponseStorage {
    
    // MARK: - Private
    
    private func clearData() {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = Product.fetchRequest()
                let requestEntity = try context.fetch(fetchRequest)
                _ = requestEntity.map {context.delete($0)}
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}

extension CoreDataProductsResponseStorage: ProductsResponseStorage {
    
    func getResponse(completion: @escaping (Result<[ProductResponseDTO],
                                            CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = Product.fetchRequest()
                let requestEntity = try context.fetch(fetchRequest)
                var coreDataDTO = Product.toProductResponse(requestEntity)
                coreDataDTO.removeAll(where: { product in {product.image?.height == 0}()})
                completion(.success(coreDataDTO))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func save(response: ProductsDTO,
              completion: @escaping (Result<[ProductResponseDTO], Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            self.clearData()
            for product in response.products {
                if let _ = product.toProductCoreDataEntityForInserting(context: context) {
                    do {
                        try context.save()
                    } catch {
                        ///Error 
                    }
                }
                
            }
            
        }
        
    }
    
}
