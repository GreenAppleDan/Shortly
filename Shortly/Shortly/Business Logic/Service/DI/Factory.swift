//
//  Factory.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import Foundation

protocol Factory {
    func makeShortenUrlService() -> ShortenUrlService
    func makeShortenedLinkDataStorage() -> ShortenedLinkDataStorage
}

final class BaseFactory: Factory {
    
    private lazy var requestAdapter: RequestAdapter = ApiRequestAdapter()
    
    private lazy var apiClient: APIClient = Client(requestAdapter: requestAdapter)
    
    private lazy var shortenUrlService: ShortenUrlService = BaseShortenUrlService(apiClient: apiClient)
    
    private lazy var shortenedLinkDataStorage: ShortenedLinkDataStorage = BaseShortenedLinkDataStorage()
    
    func makeShortenUrlService() -> ShortenUrlService {
        shortenUrlService
    }
    
    func makeShortenedLinkDataStorage() -> ShortenedLinkDataStorage {
        shortenedLinkDataStorage
    }
}
