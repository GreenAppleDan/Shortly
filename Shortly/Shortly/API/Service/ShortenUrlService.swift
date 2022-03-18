//
//  ShortenUrlService.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import Foundation

struct ShortenedLinkDataUniqueIdentifiable: Codable, Hashable {
    let id: UUID
    let fullShortLink: String
    let originalLink: String
    
    init(shortenedLinkData: ShortenedLinkData) {
        id = .init()
        fullShortLink = shortenedLinkData.fullShortLink
        originalLink = shortenedLinkData.originalLink
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

protocol ShortenUrlService {
    func shortenUrl(linkString: String,
                    completion: @escaping ResultHandler<ShortenedLinkDataUniqueIdentifiable>)
}

final class BaseShortenUrlService: APIService, ShortenUrlService {
    func shortenUrl(linkString: String, completion: @escaping ResultHandler<ShortenedLinkDataUniqueIdentifiable>) {
        apiClient.request(ShortenLinkEndpoint(linkString: linkString)) { result in
            
            switch result {
            case .success(let shortenedLinkData):
                completion(.success(.init(shortenedLinkData: shortenedLinkData)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
