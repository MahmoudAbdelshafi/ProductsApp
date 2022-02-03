//
//  ProductsPersistentRepository.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 31/01/2022.
//

import Foundation

protocol ProductsPersistentRepository {
    func fetchRecentProducts(completion: @escaping (Result<ProductsPage, Error>) -> Void)
    func saveRecentProducts(products: ProductsPage, completion: @escaping (Result<ProductsPage, Error>) -> Void)
}
