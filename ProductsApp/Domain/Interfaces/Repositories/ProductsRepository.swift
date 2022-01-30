//
//  ProductsRepository.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//

import Foundation

protocol ProductsRepository {
    func fetchProductsList(completion: @escaping (Result<ProductsPage, Error>) -> Void)
}
