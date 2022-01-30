//
//  AppDIContainer.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - DIContainers of scenes
    
    func makeProductsScenesDIContainer() -> ProductsScenesDiContainer {
      return ProductsScenesDiContainer()
    }
}
