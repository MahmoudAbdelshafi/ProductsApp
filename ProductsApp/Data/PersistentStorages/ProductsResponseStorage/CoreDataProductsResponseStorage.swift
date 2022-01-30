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
    
    private func fetchRequest() -> NSFetchRequest<Product> {
        let request: NSFetchRequest = Product.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d")
        return request
    }
    
    //    private func deleteResponse(for requestDto: Product, in context: NSManagedObjectContext) {
    //        let request = fetchRequest(for: requestDto.id)
    //
    //        do {
    //            if let result = try context.fetch(request).first {
    //                context.delete(result)
    //            }
    //        } catch {
    //            print(error)
    //        }
    //    }
}

extension CoreDataProductsResponseStorage: ProductsResponseStorage {
    func getResponse(for request: ProductResponseDTO, completion: @escaping (Result<ProductResponseDTO?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            //            do {
            //                let fetchRequest = self.fetchRequest()
            //                let requestEntity = try context.fetch(fetchRequest).first
            //
            //
            //            } catch {
            //                completion(.failure(CoreDataStorageError.readError(error)))
            //            }
        }
    }
    
    func save(response: ProductResponseDTO, for requestDto: ProductResponseDTO) {
        
    }
    
    
}
