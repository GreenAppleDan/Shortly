//
//  ShortenedLinkDataStorage.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import Foundation

struct ShortenedLinks: Codable {
    var value: [ShortenedLinkData]
}

protocol ShortenedLinkDataStorage {
    var shortenedLinks: ShortenedLinks { get set }
}

final class BaseShortenedLinkDataStorage: ShortenedLinkDataStorage {
    
    private let key = "Shortly.ShortenedLinks"
    
    private let storage: DataStorage
    private lazy var encoder = JSONEncoder()
    private lazy var decoder = JSONDecoder()
    
    var shortenedLinks: ShortenedLinks {
        
        get {
            if let savedFavorites = try? storage.data(for: key),
               let favorites = try? decoder.decode(ShortenedLinks.self, from: savedFavorites) {
                return favorites
            } else {
                return ShortenedLinks(value: [])
            }
        }
        
        set {
            guard let encoded = try? encoder.encode(newValue) else { return }
            try? storage.set(encoded, for: key)
        }
    }
    
    init(storage: DataStorage = UserDefaults.standard) {
        self.storage = storage
    }
}
