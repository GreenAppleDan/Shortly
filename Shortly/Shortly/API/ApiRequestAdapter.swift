//
//  ApiRequestAdapter.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import Foundation

protocol RequestAdapter {
    func adapt(_ urlRequest: URLRequest) -> URLRequest
}

/// Adapter for API calls
final class ApiRequestAdapter: RequestAdapter {

    private let baseUrl = URL(string: "https://api.shrtco.de/v2/")!
    
    func adapt(_ urlRequest: URLRequest) -> URLRequest {
        guard let url = urlRequest.url else { return urlRequest }
        
        var request = urlRequest
        request.url = appendingBaseURL(to: url)
        
        return request
    }
    
    // MARK: - Private

    private func appendingBaseURL(to url: URL) -> URL {
        guard url.host == nil else { return url }
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
        components.percentEncodedQuery = url.query
        return components.url!.appendingPathComponent(url.path)
    }
}
