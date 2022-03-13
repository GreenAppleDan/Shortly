//
//  MainViewController.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let factory: Factory
    
    init(factory: Factory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        let shortenLinkView = addShortenLinkView()
        addMainContainerVc(shortenLinkView: shortenLinkView)
    }
    
    private func addShortenLinkView() -> UIView {
        let shortenLinkView = ShortenLinkview()
        shortenLinkView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(shortenLinkView)
        
        NSLayoutConstraint.activate([
            shortenLinkView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shortenLinkView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shortenLinkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            shortenLinkView.heightAnchor.constraint(equalToConstant: 204)
        ])
        
        return shortenLinkView
    }
    
    private func addMainContainerVc(shortenLinkView: UIView) {
        let mainContainerVc = MainContainerViewController(factory: factory)
        addChild(mainContainerVc)
        mainContainerVc.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainContainerVc.view)
        
        NSLayoutConstraint.activate([
            mainContainerVc.view.topAnchor.constraint(equalTo: view.topAnchor),
            mainContainerVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainContainerVc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainContainerVc.view.bottomAnchor.constraint(equalTo: shortenLinkView.topAnchor)
        ])
        
        mainContainerVc.didMove(toParent: self)
    }
}
