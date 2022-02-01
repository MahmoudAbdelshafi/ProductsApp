//
//  ProductsResponseStorage.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 29/01/2022.
//

import Foundation

protocol ProductsResponseStorage {
    func getResponse(completion: @escaping (Result<[ProductResponseDTO], CoreDataStorageError>) -> Void)
    func save(response: ProductsDTO, completion: @escaping (Result<[ProductResponseDTO], Error>) -> Void)
}
