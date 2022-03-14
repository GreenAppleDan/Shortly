//
//  ShortenedLinksPublisher.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import Combine

protocol ShortenedLinksDataProcessor {
    func addLinkData(_ linkData: ShortenedLinkData)
    func removeLinkData(_ linkData: ShortenedLinkData)
    
    var shortenedLinkPublisher: AnyPublisher<ShortenedLinkStream, Never> { get }
}

struct ShortenedLinkStream {
    
    enum OperationType {
        case add(ShortenedLinkData)
        case remove(ShortenedLinkData)
    }
    
    let shortenedLinks: ShortenedLinks
    let latestOperation: OperationType?
}

class ShortenedLinksPublisher: ShortenedLinksDataProcessor {
    
    private var shortenedLinkDataStorage: ShortenedLinkDataStorage
    
    private var shortenedLinksubscription: AnyCancellable? = nil
    
    private let shortenedLinkCVS: CurrentValueSubject<ShortenedLinkStream, Never>
    
    lazy var shortenedLinkPublisher: AnyPublisher<ShortenedLinkStream, Never> =  shortenedLinkCVS.eraseToAnyPublisher()
    
    init(shortenedLinkDataStorage: ShortenedLinkDataStorage) {
        self.shortenedLinkDataStorage = shortenedLinkDataStorage
        shortenedLinkCVS = CurrentValueSubject(.init(shortenedLinks: shortenedLinkDataStorage.shortenedLinks,
                                                     latestOperation: nil))
        
        shortenedLinksubscription = shortenedLinkCVS.sink { [weak self] shortenedLinkStream in
            self?.shortenedLinkDataStorage.shortenedLinks = shortenedLinkStream.shortenedLinks
        }
    }
    
    func addLinkData(_ linkData: ShortenedLinkData) {
        var shortenedLinks = shortenedLinkCVS.value.shortenedLinks
        shortenedLinks.addLinkData(linkData)
        shortenedLinkCVS.send(.init(shortenedLinks: shortenedLinks, latestOperation: .add(linkData)))
    }
    
    func removeLinkData(_ linkData: ShortenedLinkData) {
        var shortenedLinks = shortenedLinkCVS.value.shortenedLinks
        shortenedLinks.removeLinkData(linkData)
        shortenedLinkCVS.send(.init(shortenedLinks: shortenedLinks, latestOperation: .remove(linkData)))
    }
}
