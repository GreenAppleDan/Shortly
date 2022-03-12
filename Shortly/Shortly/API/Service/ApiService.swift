//
//  ApiService.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import Foundation

/// Base API Service
class APIService {

    /// API Client.
    let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}
