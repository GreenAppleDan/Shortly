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
    }
}
