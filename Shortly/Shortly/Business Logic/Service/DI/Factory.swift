//
//  Factory.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import Foundation

protocol Factory {
    func makeShortenUrlService() -> ShortenUrlService
}

final class BaseFactory: Factory {
    
    private lazy var requestAdapter: RequestAdapter = ApiRequestAdapter()
    
    private lazy var apiClient: APIClient = Client(requestAdapter: requestAdapter)
    
    func makeShortenUrlService() -> ShortenUrlService {
        BaseShortenUrlService(apiClient: apiClient)
    }
}
