//
//  ApiClient.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import Foundation
typealias APIResult<Value> = Swift.Result<Value, Error>

/// API Client Protocol
protocol APIClient: AnyObject {

    func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (APIResult<T.Content>) -> Void) where T: Endpoint
}


final class Client: APIClient {
    
    private let session: URLSession
    
    /// Callback queue
    private let completionQueue = DispatchQueue.main
    
    /// Request adapter
    let requestAdapter: RequestAdapter
    
    init(requestAdapter: RequestAdapter) {
        let config = URLSessionConfiguration.ephemeral
        config.timeoutIntervalForRequest = 15.0
        session = .init(configuration: config)
        self.requestAdapter = requestAdapter
    }
    
        /// Send a request to API
        ///
        /// - Parameters:
        ///   - endpoint: Final point of request
        ///   - completionHandler: Request result processor
    func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (APIResult<T.Content>) -> Void) where T: Endpoint {
            
            do {
                let urlRequest = try endpoint.makeRequest()
                let request = requestAdapter.adapt(urlRequest)
                
                let task = session.dataTask(with: request) { [unowned self] (data, _, error) in
                    
                    if let error = error {
                        main { completionHandler(.failure(error)) }
                    } else if let data = data {
                        do {
                            let content = try endpoint.content(with: data)
                            main { completionHandler(.success(content)) }
                        } catch {
                            main { completionHandler(.failure(error)) }
                        }
                        
                    } else {
                        main { completionHandler(.failure(UknownError())) }
                    }
                }
                
                task.resume()
            } catch {
                main { completionHandler(.failure(error)) }
            }
        }
    
    /// asynchronously add operation on the main queue
    private func main(completion: @escaping (() -> Void)) {
        completionQueue.async(execute: completion)
    }
}


