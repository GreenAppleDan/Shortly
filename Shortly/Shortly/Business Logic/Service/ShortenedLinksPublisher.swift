//
//  ShortenedLinksPublisher.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import Combine

protocol ShortenedLinksDataProcessor {
    func addLinkData(_ linkData: ShortenedLinkDataUniqueIdentifiable)
    func removeLinkData(_ linkData: ShortenedLinkDataUniqueIdentifiable)
    
    var shortenedLinkPublisher: AnyPublisher<ShortenedLinks, Never> { get }
}

final class ShortenedLinksPublisher: ShortenedLinksDataProcessor {
    
    private var shortenedLinkDataStorage: ShortenedLinkDataStorage
    
    private var shortenedLinksubscription: AnyCancellable? = nil
    
    private let shortenedLinkCVS: CurrentValueSubject<ShortenedLinks, Never>
    
    lazy var shortenedLinkPublisher: AnyPublisher<ShortenedLinks, Never> =  shortenedLinkCVS.eraseToAnyPublisher()
    
    init(shortenedLinkDataStorage: ShortenedLinkDataStorage) {
        self.shortenedLinkDataStorage = shortenedLinkDataStorage
        shortenedLinkCVS = CurrentValueSubject(shortenedLinkDataStorage.shortenedLinks)
        
        shortenedLinksubscription = shortenedLinkCVS.sink { [weak self] shortenedLinks in
            self?.shortenedLinkDataStorage.shortenedLinks = shortenedLinks
        }
    }
    
    func addLinkData(_ linkData: ShortenedLinkDataUniqueIdentifiable) {
        var shortenedLinks = shortenedLinkCVS.value
        shortenedLinks.addLinkData(linkData)
        shortenedLinkCVS.send(shortenedLinks)
    }
    
    func removeLinkData(_ linkData: ShortenedLinkDataUniqueIdentifiable) {
        var shortenedLinks = shortenedLinkCVS.value
        shortenedLinks.removeLinkData(linkData)
        shortenedLinkCVS.send(shortenedLinks)
    }
}
