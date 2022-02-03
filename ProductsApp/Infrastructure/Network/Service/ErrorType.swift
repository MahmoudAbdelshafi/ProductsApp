//
//  ErrorType.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//

import Foundation

/// Error Cases

enum ErrorType: Error {
    case parseUrlFail
    case notFound
    case validationError
    case serverError
    case defaultError
    case decodingError
    case noInternet
    case error(Error)
    
    var errorDescription: String? {
        switch self {
        case .parseUrlFail:
            return "Cannot initial URL object."
        case .notFound:
            return "Not Found"
        case .validationError:
            return "Validation Errors"
        case .serverError:
            return "Internal Server Error"
        case .defaultError:
            return "Something went wrong."
        case .decodingError:
            return "Couldn't decode data!"
        case .noInternet:
            return "No Internet Connection"
        case .error:
            return self.localizedDescription
        }
    }
}
