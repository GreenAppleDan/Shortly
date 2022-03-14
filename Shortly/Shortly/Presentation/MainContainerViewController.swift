//
//  MainContainerViewController.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import UIKit
import Combine

final class MainContainerViewController: ContainerViewController {
    
    private lazy var welcomeViewController: WelcomeViewController = .init()
    private let linksListViewController: LinkListViewController
    
    private let factory: Factory
    private let shortenedLinksDataProcessor: ShortenedLinksDataProcessor
    
    private var shortenedLinkSubscription: AnyCancellable?
    
    init(factory: Factory) {
        self.factory = factory
        self.shortenedLinksDataProcessor = factory.makeShortenedLinksDataProcessor()
        linksListViewController = .init(factory: factory)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContent(linksListViewController, animated: false)
        
        shortenedLinkSubscription = shortenedLinksDataProcessor.shortenedLinkPublisher.sink { [weak self] shortenedLinkStream in
            self?.updateState(linkData: shortenedLinkStream.shortenedLinks)
        }
    }
    
    private func updateState(linkData: ShortenedLinks) {
        if linkData.value.isEmpty, contentViewController !== welcomeViewController {
            setContent(welcomeViewController, animated: true)
        } else if !linkData.value.isEmpty, contentViewController !== linksListViewController {
            setContent(linksListViewController, animated: true)
        }
    }
}
