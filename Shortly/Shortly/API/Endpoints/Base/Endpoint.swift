//
//  Endpoint.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import Foundation

/// The endpoint to work with a remote content.
protocol Endpoint {

    /// Resource type.
    associatedtype Content

    /// Create a new `URLRequest`.
    ///
    /// - Returns: Resource request.
    /// - Throws: Any error creating request.
    func makeRequest() throws -> URLRequest

    /// Obtain new content from response with body.
    ///
    /// - Parameters:
    ///   - body: The response body.
    /// - Returns: A new endpoint content.
    /// - Throws: Any error creating content.
    func content(with body: Data) throws -> Content
}
