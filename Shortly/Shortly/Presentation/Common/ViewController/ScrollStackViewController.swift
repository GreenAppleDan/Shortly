//
//  ScrollStackViewController.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import UIKit

class ScrollStackViewController: UIViewController {
    
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.pin(to: view)
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        addStackView()
        
        scrollView.preservesSuperviewLayoutMargins = true
        stackView.preservesSuperviewLayoutMargins = true
    }
    
    private func addStackView() {
        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor, constant: -20),
            stackView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            contentGuide.widthAnchor.constraint(equalTo: frameGuide.widthAnchor)
        ])
    }
    
    // MARK: - Managing subviews

    /// Adding view to stack
    func addView(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
    
    // MARK: - Managing child UIViewController

    func addArrangedChild(_ child: UIViewController) {
        addChild(child)
        addView(child.view)

        child.didMove(toParent: self)
    }
}
