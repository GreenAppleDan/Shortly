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

struct ShortenedLinkData: Decodable {
    let fullShortLink: String
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
        let url = URL(string: "shorten?url=\(linkString)")!
        return URLRequest(url: url)
    }
}
