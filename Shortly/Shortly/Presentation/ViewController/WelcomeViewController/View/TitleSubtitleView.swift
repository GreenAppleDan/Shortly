//
//  TitleSubtitleView.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import UIKit

final class TitleSubtitleView: UIView {
    
    private let titleText: String
    private let subtitleText: String
    
    init(titleText: String, subtitleText: String) {
        self.titleText = titleText
        self.subtitleText = subtitleText
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let title = addTitle()
        addSubtitle(title: title)
    }
    
    private func addTitle() -> UIView {
        let title = UILabel()
        
        title.text = titleText
        title.textAlignment = .center
        title.numberOfLines = 0
        
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: title.trailingAnchor),
            title.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        return title
    }
    
    private func addSubtitle(title: UIView) {
        let subtitle = UILabel()
        
        subtitle.text = subtitleText
        subtitle.textAlignment = .center
        subtitle.numberOfLines = 0
        
        addSubview(subtitle)
        
        NSLayoutConstraint.activate([
            subtitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: subtitle.trailingAnchor),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 7),
            subtitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
