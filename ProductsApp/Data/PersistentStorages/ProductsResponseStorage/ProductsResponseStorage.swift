//
//  ProductsResponseStorage.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 29/01/2022.
//

import Foundation

protocol ProductsResponseStorage {
    func getResponse(for request: ProductResponseDTO, completion: @escaping (Result<ProductResponseDTO?, CoreDataStorageError>) -> Void)
    func save(response: ProductResponseDTO, for requestDto: ProductResponseDTO)
}
