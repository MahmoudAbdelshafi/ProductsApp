//
//  ProductsViewModelTests.swift
//  ProductsAppTests
//
//  Created by Mahmoud Abdelshafi on 30/01/2022.
//

import XCTest
@testable import ProductsApp

class ProductsViewModelTests: XCTestCase {
    
    class FetchProductsUseCaseMock: FetchProductsUseCase {
        
        var expectation: XCTestExpectation?
        var error: Error?
        var page = ProductsPage(products: [])
        
        func execute(completion: @escaping (Result<ProductsPage, Error>) -> Void) {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(page))
            }
            expectation?.fulfill()
        }
    }
    
    func testLoadData_WhenViewLoads() {
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
}
