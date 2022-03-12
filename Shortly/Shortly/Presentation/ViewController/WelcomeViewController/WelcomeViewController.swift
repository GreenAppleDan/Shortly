//
//  WelcomeViewController.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    init() {
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
        let title = addTitle()
        addImage(title: title)
    }
    
    private func addTitle() -> UIView {
        let title = UIImageView()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55)
        ])
        
        return title
    }
    
    private func addImage(title: UIView) {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 14),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 375/324)
        ])
    }
    
    private func addDescription(image: UIView) {
        let description = TitleSubtitleView(
            titleText: "Let’s get started!",
            subtitleText: "Paste your first link into the field to shorten it")
        
        view.addSubview(description)
        
        NSLayoutConstraint.activate([
            description.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            view.trailingAnchor.constraint(equalTo: description.trailingAnchor, constant: 48),
            description.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 12),
            description.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: 10)
        ])
    }
}
