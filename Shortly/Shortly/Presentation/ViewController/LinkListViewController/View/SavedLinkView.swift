//
//  SavedLinkView.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import UIKit

final class SavedLinkView: UIView {
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let deleteButton = addDeleteButton()
        addFullLinkLabel(deleteButton: deleteButton)
        let separator = addSeparator()
        let shortenedLinkLabel = addShortenedLinkLabel(separator: separator)
        addCopyButton(shortenedLinkLabel: shortenedLinkLabel)
    }
    
    private func addDeleteButton() -> UIView {
        let deleteButton = UIButton()
        let image = #imageLiteral(resourceName: "del")
        deleteButton.setImage(image, for: .normal)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteButton.heightAnchor.constraint(equalToConstant: 18),
            deleteButton.widthAnchor.constraint(equalToConstant: 14),
            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            trailingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 26)])
        
        return deleteButton
    }
    
    private func addFullLinkLabel(deleteButton: UIView) {
        let fullLinkLabel = UILabel()
        
        fullLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fullLinkLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            fullLinkLabel.topAnchor.constraint(equalTo: topAnchor, constant: 23),
            deleteButton.leadingAnchor.constraint(equalTo: fullLinkLabel.trailingAnchor, constant: 20)])
    }
    
    private func addSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .inactive
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.topAnchor.constraint(equalTo: topAnchor, constant: 57)
        ])
        
        return separator
    }
    
    private func addShortenedLinkLabel(separator: UIView) -> UIView {
        let shortenedLinkLabel = UILabel()
        shortenedLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shortenedLinkLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 12),
            shortenedLinkLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            trailingAnchor.constraint(equalTo: shortenedLinkLabel.trailingAnchor, constant: 23)
        ])
        
        return shortenedLinkLabel
    }
    
    private func addCopyButton(shortenedLinkLabel: UIView) {
        let copyButton = SimpleButton()
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            copyButton.topAnchor.constraint(equalTo: shortenedLinkLabel.bottomAnchor, constant: 23),
            copyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            trailingAnchor.constraint(equalTo: copyButton.trailingAnchor, constant: 23),
            bottomAnchor.constraint(equalTo: copyButton.bottomAnchor, constant: 23),
            copyButton.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
}
