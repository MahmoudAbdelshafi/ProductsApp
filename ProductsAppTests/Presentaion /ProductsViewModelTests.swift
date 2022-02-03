//
//  ProductsViewModelTests.swift
//  ProductsAppTests
//
//  Created by Mahmoud Abdelshafi on 30/01/2022.
//

import XCTest
@testable import ProductsApp

class ProductsViewModelTests: XCTestCase {
    
    enum FetchProductsUseTestingError:Error {
        case faildFetchingProducts
    }
    
    class FetchProductsUseCaseMock: FetchProductsUseCase {
        
        var expectation: XCTestExpectation?
        var error: FetchProductsUseTestingError?
        var page = ProductsPage(products: [])
        
        func execute(completion: @escaping (Result<ProductsPage, Error>) -> Void) {
            if let _ = error {
                completion(.failure(FetchProductsUseTestingError.faildFetchingProducts))
            } else {
                completion(.success(page))
            }
            expectation?.fulfill()
        }
    }
    
    func testLoadData_WhenViewLoads_Successfully() {
        //given
        let fetchProductsUseCaseMock = FetchProductsUseCaseMock()
        fetchProductsUseCaseMock.expectation = self.expectation(description: "contains only first page")
        let viewModel = DefultProductsViewModel(fetchProductsUseCase: fetchProductsUseCaseMock)
        
        //When
        viewModel.viewDidLoad()
        
        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertTrue(viewModel.hasMorePages)
    }
    
    func test_fetchProducts_fails() {
        //given
        let fetchProductsUseCaseMock = FetchProductsUseCaseMock()
        fetchProductsUseCaseMock.expectation = self.expectation(description: "Fetching products should fail")
        fetchProductsUseCaseMock.error = .faildFetchingProducts
        let viewModel = DefultProductsViewModel(fetchProductsUseCase: fetchProductsUseCaseMock)
        
        //When
        viewModel.viewDidLoad()
        
        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(fetchProductsUseCaseMock.error)
        XCTAssertEqual(viewModel.currentPage, 0)
    }
}
