//
//  ShortenUrlService.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import Foundation

protocol ShortenUrlService {
    func shortenUrl(linkString: String,
                    completion: @escaping ResultHandler<ShortenedLinkData>)
}

final class BaseShortenUrlService: APIService, ShortenUrlService {
    func shortenUrl(linkString: String, completion: @escaping ResultHandler<ShortenedLinkData>) {
        apiClient.request(ShortenLinkEndpoint(linkString: linkString), completionHandler: completion)
    }
}
