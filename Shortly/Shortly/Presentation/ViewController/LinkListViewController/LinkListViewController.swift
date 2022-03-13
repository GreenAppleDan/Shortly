//
//  LinkListViewController.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import UIKit
import Combine

final class LinkListViewController: ScrollStackViewController {
    
    override var stackViewLeftPadding: CGFloat { 25 }
    override var stackViewRightPadding: CGFloat { 25 }
    
    private let shortenedLinksDataProcessor: ShortenedLinksDataProcessor
    private var shortenedLinkSubscription: AnyCancellable?
    
    init(factory: Factory) {
        self.shortenedLinksDataProcessor = factory.makeShortenedLinksDataProcessor()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.spacing = 20
        view.backgroundColor = .lightGray
        
        setupUI(linkData: shortenedLinksDataProcessor.shortenedLinkCVS.value.shortenedLinks)
        
        shortenedLinkSubscription = shortenedLinksDataProcessor.shortenedLinkCVS.sink { [weak self] shortenedLinkStream in
            
            switch shortenedLinkStream.latestOperation {
            case .add(let linkData):
                self?.addSavedLinkView(linkData: linkData)
            default:
                break
            }
            
        }
    }
    
    private func setupUI(linkData: ShortenedLinks) {
        addTitle()
        
        linkData.value.forEach { linkData in
            
            let view = createSavedLinkView(linkData: linkData)
            addView(view)
        }
    }
    
    private func addSavedLinkView(linkData: ShortenedLinkData) {
        let view = createSavedLinkView(linkData: linkData)
        addView(view)
    }
    
    private func addTitle() {
        let label = UILabel()
        label.text = "Your Link History"
        label.textAlignment = .center
        
        addView(label)
    }
    
    private func createSavedLinkView(linkData: ShortenedLinkData) -> SavedLinkView {
        let view = SavedLinkView(fullLink: linkData.originalLink, shortenedLink: linkData.fullShortLink)
        
        view.onDelete = { [weak self] in
            self?.stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
            self?.shortenedLinksDataProcessor.removeLinkData(linkData)
        }
        
        view.onCopy = { button in
            UIPasteboard.general.string = linkData.fullShortLink
            button.changeProperties(properties: .init(backgroundColor: .darkPurple, text: "COPIED!"), for: 3)
        }
        
        return view
    }
}
