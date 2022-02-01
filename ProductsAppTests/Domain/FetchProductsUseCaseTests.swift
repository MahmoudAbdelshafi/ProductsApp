//
//  FetchProductsUseCaseTests.swift
//  ProductsAppTests
//
//  Created by Mahmoud Abdelshafi on 29/01/2022.
//

import XCTest
@testable import ProductsApp

class FetchProductsUseCaseTests: XCTestCase {
    
    static let productsPages: ProductsPage = {
        let image = Image(width: 300, height: 200, url: "https:")
        let DTO1 = ProductResponseDTO(id: 1, productDescription: "product1", image: image, price: 10)
        let DTO2 = ProductResponseDTO(id: 2, productDescription: "product2", image: image, price: 20)
        let productsDTO = ProductsDTO(products: [DTO1, DTO2]).toProductsPageDomain()
        return productsDTO
    }()
    
    struct ProductsRepositoryMock: ProductsRepository {
        var result: Result<ProductsPage, Error>
        func fetchProductsList(completion: @escaping (Result<ProductsPage, Error>) -> Void) {
            completion(result)
        }
    }
    
    struct ProductsPersistentRepositoryMock: ProductsPersistentRepository {
        func fetchRecentsQueries(completion: @escaping (Result<ProductsPage, Error>) -> Void) {
            
        }
        
        func saveRecentQuery(products: ProductsPage, completion: @escaping (Result<ProductsPage, Error>) -> Void) {
            
        }
        
        
    }
    
    func testFetchProductsUseCase_whenSuccessfullyFetchesProducts() {
        //Arrange
        let expectation = self.expectation(description: "Successfully Fetches Products")
        expectation.expectedFulfillmentCount = 1
        let repo = ProductsRepositoryMock(result:.success(FetchProductsUseCaseTests.productsPages))
        let pressistentRepo = ProductsPersistentRepositoryMock()
        let _ = DefaultFetchTopStoriesUseCase(productsRepository: repo, productsPersistentRepository: pressistentRepo)
        
        // Act
        var recents = ProductsPage(products: [])
        repo.fetchProductsList { result in
            recents = try! result.get()
            expectation.fulfill()
        }
        
        //Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(recents.products.first?.image?.height == 200)
        XCTAssertTrue(recents.products.first?.image?.width == 300)
    }
    
}
