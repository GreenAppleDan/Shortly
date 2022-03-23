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
    
    private let shortenedLinksDataProcessor: ShortenedLinksDataProcessor
    
    private var shortenedLinkSubscription: AnyCancellable?
    
    init(shortenedLinksDataProcessor: ShortenedLinksDataProcessor) {
        self.shortenedLinksDataProcessor = shortenedLinksDataProcessor
        linksListViewController = .init(shortenedLinksDataProcessor: shortenedLinksDataProcessor)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shortenedLinkSubscription = shortenedLinksDataProcessor.shortenedLinkPublisher.sink { [weak self] shortenedLinks in
            self?.updateState(linkData: shortenedLinks)
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
