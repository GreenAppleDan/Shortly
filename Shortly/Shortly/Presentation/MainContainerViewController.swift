//
//  MainContainerViewController.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import UIKit

final class MainContainerViewController: ContainerViewController {
    
    private lazy var welcomeViewController: WelcomeViewController = .init()
    
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
        updateState()
    }
    
    private func updateState() {
        // TODO: update state when shortened links become more than 0 in count, or get back to zero count
        
        setContent(welcomeViewController, animated: true)
    }
}
