//
//  ProductDetailsViewModel.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 30/01/2022.
//

import Foundation


protocol ProductDetailsViewModelOutput {
    var productDetails: Observable<ProductDetailsDataViewModel?> { get }
}

protocol ProductDetailsViewModelInput { }

protocol ProductDetailsViewModel: ProductDetailsViewModelOutput, ProductDetailsViewModelInput { }

final class DefultProductDetailsViewModel: ProductDetailsViewModel {
    
    var productDetails: Observable<ProductDetailsDataViewModel?> = Observable(nil)

    init(dataModel: ProductDetailsDataViewModel) {
        productDetails.value = dataModel
    }
    
}


