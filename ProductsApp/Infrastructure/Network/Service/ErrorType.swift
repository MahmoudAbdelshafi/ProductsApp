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
    case errorMessage(_ error: String)
    case decodingError
    
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
        case .errorMessage(let error):
            return error
        case .decodingError:
            return "Couldn't decode data!"
        }
    }
}
