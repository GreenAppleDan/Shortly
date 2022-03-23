//
//  Factory.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import Foundation

final class BaseFactory {
    
    static let shared = BaseFactory()
    private init() {}
    
    private lazy var requestAdapter: RequestAdapter = ApiRequestAdapter()
    
    private lazy var apiClient: APIClient = Client(requestAdapter: requestAdapter)
    
    private lazy var shortenUrlService: ShortenUrlService = BaseShortenUrlService(apiClient: apiClient)
    
    private lazy var shortenedLinkDataStorage: ShortenedLinkDataStorage = BaseShortenedLinkDataStorage()
    
    private lazy var shortenedLinksDataProcessor: ShortenedLinksDataProcessor = ShortenedLinksPublisher(shortenedLinkDataStorage: shortenedLinkDataStorage)
    
    func makeShortenUrlService() -> ShortenUrlService {
        shortenUrlService
    }
    
    func makeShortenedLinkDataStorage() -> ShortenedLinkDataStorage {
        shortenedLinkDataStorage
    }
    
    func makeShortenedLinksDataProcessor() -> ShortenedLinksDataProcessor {
        shortenedLinksDataProcessor
    }
}
