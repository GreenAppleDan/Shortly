//
//  ShortenLinkEndpoint.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import Foundation


struct ShortenLinkEndpointResponse: Decodable {
    let result: ShortenedLinkData
}

struct ShortenedLinkData: Codable {
    let fullShortLink: String
    let originalLink: String
}

struct ShortenLinkEndpoint: BaseEndpoint {
    
    typealias Content = ShortenedLinkData
    
    private let linkString: String
    
    func content(from root: ShortenLinkEndpointResponse) -> ShortenedLinkData {
        root.result
    }
    
    init(linkString: String) {
        self.linkString = linkString
    }
    
    func makeRequest() throws -> URLRequest {
        guard let url = URL(string: "shorten?url=\(linkString)") else {
            throw InvalidURLError()
        }
        return URLRequest(url: url)
    }
}
