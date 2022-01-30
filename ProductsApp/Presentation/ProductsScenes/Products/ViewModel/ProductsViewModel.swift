//
//  ProductsViewModel.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//

import Foundation

struct ProductsViewModelActions {
    let showProductDetails: (ProductDetailsDataViewModel) -> Void
}

enum ProductsListViewModelLoading {
    case nextPage
}

protocol ProductsViewModelOutput {
    var error: Observable<String> { get }
    var products: Observable<ProductsPage> { get }
    var loading: Observable<ProductsListViewModelLoading?> { get }
    var errorTitle: String { get }
    var currentPage: Int { get }
    var hasMorePages: Bool { get }
    func collectionViewHeight(indexPath: IndexPath) -> Int
}

protocol ProductsViewModelInput {
    func viewDidLoad()
    func loadNextPage()
    func didSelectItem(at index: Int)
}

protocol ProductsViewModel: ProductsViewModelOutput, ProductsViewModelInput { }

final class DefultProductsViewModel: ProductsViewModel {
    
    //MARK: - Properties
    
    private let fetchProductsUseCase: FetchProductsUseCase
    
    var currentPage: Int = 0
    var hasMorePages: Bool { currentPage < totalPageCount }
    private var totalPageCount: Int = 5
    private let actions: ProductsViewModelActions?
    
    //MARK: - OUTPUT
    
    let loading: Observable<ProductsListViewModelLoading?> = Observable(.none)
    var error: Observable<String> = Observable("")
    var products: Observable<ProductsPage> = Observable(ProductsPage(products: []))
    var errorTitle: String = "Error"
    
    //MARK: - Init
    
    init(fetchProductsUseCase: FetchProductsUseCase,
         actions: ProductsViewModelActions? = nil) {
        self.fetchProductsUseCase = fetchProductsUseCase
        self.actions = actions
    }
    
    //MARK: - Private
    
    private func load(loading: ProductsListViewModelLoading) {
        self.loading.value = loading
        Loader.show()
        fetchProductsUseCase.execute(completion: { result in
            Loader.hide()
            switch result {
            case .success(let products):
                self.appendPage(productsPage: products)
                
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
            self.loading.value = .none
        })
    }
    
    private func appendPage(productsPage: ProductsPage) {
        self.products.value.products.append(contentsOf: productsPage.products)
        currentPage += 1
    }
}

// MARK: - INPUT. View event methods

extension DefultProductsViewModel {
    
    func viewDidLoad() {
        load(loading: .nextPage)
    }
    
    func loadNextPage() {
        guard hasMorePages, loading.value == .none else { return }
        load(loading: .nextPage)
    }
    
    func didSelectItem(at index: Int) {
        let selectedProduct = products.value.products[index]
        let productDetailsDataModel = ProductDetailsDataViewModel(
            discription: selectedProduct.productDescription,
            imgUrl: selectedProduct.image?.url)
        actions?.showProductDetails(productDetailsDataModel)
    }
    
}

// MARK: - OUTPUT. Methods

extension DefultProductsViewModel {
    
    func collectionViewHeight(indexPath: IndexPath) -> Int {
        if let height = products.value.products[indexPath.row].image?.height {
            guard let discriptionCount = products.value.products[indexPath.row]
                    .productDescription?.count else { return 0 }
            return Int(height + ( discriptionCount * 2))
        } else {
            return 0
        }
    }
    
}
