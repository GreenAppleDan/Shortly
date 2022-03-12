//
//  Decoder.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import Foundation

extension JSONDecoder {
    static let base: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
