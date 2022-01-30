//
//  HTTPMethod.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//


import Foundation

public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

protocol TargetType {
    
    /// The target's base `URL`.
    var baseURL: String { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// The type of HTTP task to be performed.
    var task: HTTPTask { get }
    
    /// The headers to be used in the request.
    var headers: [String: String]? { get }
}

extension TargetType {
    
    var baseURL: String {
        let url = URL(string: AppConfiguration().apiBaseURL)!
        return "\(url)"
    }
   
    var headers: [String : String]? {
        
        let header = [String : String]()
        
        switch self {
        default: return header
        }
    }
    
}

