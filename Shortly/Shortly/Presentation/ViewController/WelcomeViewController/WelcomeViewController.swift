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
        view.backgroundColor = .lightGray
        setup()
    }
    
    private func setup() {
        let title = addTitle()
        let image = addImage(title: title)
        addDescription(image: image)
    }
    
    private func addTitle() -> UIView {
        let title = UIImageView()
        title.image = #imageLiteral(resourceName: "logo")
        title.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        return title
    }
    
    private func addImage(title: UIView) -> UIView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "illustration")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 14),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 324/580),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 375/324),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return imageView
    }
    
    private func addDescription(image: UIView) {
        let description = TitleSubtitleView(
            titleText: "Let’s get started!",
            subtitleText: "Paste your first link into the field to shorten it")
        
        description.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(description)
        
        NSLayoutConstraint.activate([
            description.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            view.trailingAnchor.constraint(equalTo: description.trailingAnchor, constant: 48),
            description.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 12),
            view.bottomAnchor.constraint(greaterThanOrEqualTo: description.bottomAnchor, constant: 10)
        ])
    }
}
