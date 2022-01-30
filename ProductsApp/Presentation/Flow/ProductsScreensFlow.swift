//
//  ProductsScreensFlow.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//

import UIKit

protocol ProductsScreensFlowCoordinatorDependencies {
    func makeProductsScreenViewController(actions: ProductsViewModelActions) -> ProductsViewController
    func makeProductDetailsScreenViewController(dataModel: ProductDetailsDataViewModel) -> ProductDetailsViewController
}

final class ProductsScenesFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: ProductsScreensFlowCoordinatorDependencies
    
    private weak var topStoriesVC: ProductsViewController?
    
    init(navigationController: UINavigationController,
         dependencies: ProductsScreensFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let action = ProductsViewModelActions(showProductDetails: navigateToProductDetailsScreen(_:))
        let vc = dependencies.makeProductsScreenViewController(actions: action)
        
        navigationController?.pushViewController(vc, animated: false)
        topStoriesVC = vc
    }
    
    private func navigateToProductDetailsScreen(_ dataModel: ProductDetailsDataViewModel) {
        let vc = dependencies.makeProductDetailsScreenViewController(dataModel: dataModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
