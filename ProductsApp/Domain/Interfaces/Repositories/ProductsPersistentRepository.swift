//
//  ProductsPersistentRepository.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 31/01/2022.
//

import Foundation

protocol ProductsPersistentRepository {
    func fetchRecentsQueries(completion: @escaping (Result<ProductsPage, Error>) -> Void)
    func saveRecentQuery(products: ProductsPage, completion: @escaping (Result<ProductsPage, Error>) -> Void)
}
