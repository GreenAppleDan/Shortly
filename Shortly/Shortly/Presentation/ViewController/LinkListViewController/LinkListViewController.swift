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
    
    private var setupDidComplete = false
    
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
        
        shortenedLinkSubscription = shortenedLinksDataProcessor.shortenedLinkPublisher.sink { [weak self] shortenedLinkStream in
            
            guard let self = self else { return }
            
            guard !self.setupUiIfNeeded(linkData: shortenedLinkStream.shortenedLinks) else {
                return
            }
            
            switch shortenedLinkStream.latestOperation {
            case .add(let linkData):
                self.addSavedLinkView(linkData: linkData)
            default:
                break
            }
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addGradientView()
    }
    
    /// returns true if ui was set
    private func setupUiIfNeeded(linkData: ShortenedLinks) -> Bool {
        
        guard !setupDidComplete else { return false }
        
        addTitle()
        
        linkData.value.forEach { linkData in
            
            let view = createSavedLinkView(linkData: linkData)
            addView(view)
        }
        
        setupDidComplete.toggle()
        
        return true
    }
    
    private func addSavedLinkView(linkData: ShortenedLinkData) {
        let view = createSavedLinkView(linkData: linkData)
        addView(view)
    }
    
    private func addTitle() {
        let label = UILabel()
        label.text = "Your Link History"
        label.textAlignment = .center
        label.font = .poppins(type: .medium, size: 17)
        
        addView(label)
    }
    
    private func addGradientView() {
        let gradientView = UIView()
        let height: CGFloat = 65
        gradientView.frame = .init(x: 0, y: view.bounds.height - height, width: view.bounds.width, height: height)
        view.addSubview(gradientView)
        
        gradientView.applyGradient(topColor: .white.withAlphaComponent(0), bottomColor: .lightGray)
        gradientView.isUserInteractionEnabled = false
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
            button.changeProperties(properties: .init(backgroundColor: .darkPurple, text: "COPIED!"), for: 1)
        }
        
        return view
    }
}
