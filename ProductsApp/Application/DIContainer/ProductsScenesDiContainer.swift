//
//  ProductsScenesDiContainer.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//

import UIKit

final class ProductsScenesDiContainer {
    
    // MARK: - Persistent Storage
    
    lazy var productsResponseCache: ProductsResponseStorage = CoreDataProductsResponseStorage()
    
    // MARK: - Repositories
    
    func makeDefultProductsRepository() -> DefultProductsRepository {
        return DefultProductsRepository(baseAPI: makeBaseAPI(), cache: productsResponseCache)
    }
    
    func makeBaseAPI() -> BaseAPI {
        return BaseAPI.sharedInstance
    }
    
    // MARK: - Use Cases
    
    func makeFetchProductsUseCase() -> FetchProductsUseCase {
        return DefaultFetchTopStoriesUseCase(productsRepository: makeDefultProductsRepository())
    }
    
    func makeProductsViewModel(actions: ProductsViewModelActions) -> ProductsViewModel {
        return DefultProductsViewModel(fetchProductsUseCase: makeFetchProductsUseCase(), actions: actions)
    }
    
    func makeProductDetailsViewModel(dataModel: ProductDetailsDataViewModel) -> ProductDetailsViewModel {
        return DefultProductDetailsViewModel(dataModel: dataModel)
    }
    
    // MARK: - Flow Coordinators
    
    func makeProductsScenesFlowCoordinator(navigationController: UINavigationController) -> ProductsScenesFlowCoordinator {
        return ProductsScenesFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
}

// MARK: - ProductsScreensFlowCoordinatorDependencies

extension ProductsScenesDiContainer:  ProductsScreensFlowCoordinatorDependencies {
   
    
    func makeProductsScreenViewController(actions: ProductsViewModelActions) -> ProductsViewController {
        return ProductsViewController.create(with: makeProductsViewModel(actions: actions))
    }
    
    func makeProductDetailsScreenViewController(dataModel: ProductDetailsDataViewModel) -> ProductDetailsViewController {
        return ProductDetailsViewController.create(with: makeProductDetailsViewModel(dataModel: dataModel))
    }
}