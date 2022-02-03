//
//  BaseAPI.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//

import Foundation

protocol BaseAPIProtocol {
    func request<T: Decodable>(router: Router, completion: @escaping (Result<T, ErrorType>) -> ())
}

//MARK: - Base API Singleton Class

class BaseAPI: BaseAPIProtocol {
    
    static let sharedInstance = BaseAPI()
    
    private let config: URLSessionConfiguration
    private let session: URLSession
    
    private init() {
        config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func request<T: Decodable>(router: Router,
                               completion: @escaping (Result<T, ErrorType>) -> ()) {
        let session = URLSession.shared
        do {
            let task = try session.dataTask(with: router.request()) { (data, urlResponse, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(.error(error)))
                        return
                    }
                    ///Check for response.....
                    guard let statusCode = urlResponse?.getStatusCode(), (200...299).contains(statusCode) else {
                        let errorType = self.handleNetworkErrorResponse(urlResponse)
                        completion(.failure(errorType))
                        return
                    }
                    ///Successful Request
                    guard let data = data else {
                        completion(.failure(ErrorType.defaultError))
                        return
                    }
                    
                    do {
                        ///Decode data...
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(result))
                    } catch {
                        ///Couldn't decode data!
                        completion(.failure(ErrorType.decodingError))
                    }
                }
            }
            task.resume()
            
        } catch let error {
            completion(.failure(.error(error)))
        }
        
    }
}

/// Network Error Response
extension BaseAPI {
    private func handleNetworkErrorResponse(_ urlResponse: URLResponse?) -> ErrorType {
        let errorType: ErrorType
        switch urlResponse?.getStatusCode() {
        case 404:
            errorType = .notFound
        case 422:
            errorType = .validationError
        case 500:
            errorType = .serverError
        default:
            errorType = .defaultError
        }
        return errorType
    }
}

/// StatusCode
extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
