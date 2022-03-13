//
//  SavedLinkView.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import UIKit

final class SavedLinkView: UIView {
    
    private let fullLink: String
    private let shortenedLink: String
    
    var onDelete: (() -> Void)?
    var onCopy: ((TemporaryStateChangingButton) -> Void)?
    
    init(fullLink: String,
         shortenedLink: String) {
        self.fullLink = fullLink
        self.shortenedLink = shortenedLink
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        setCorners(4)
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
        
        deleteButton.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            deleteButton.heightAnchor.constraint(equalToConstant: 18),
            deleteButton.widthAnchor.constraint(equalToConstant: 14),
            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            trailingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 26)])
        
        return deleteButton
    }
    
    private func addFullLinkLabel(deleteButton: UIView) {
        let fullLinkLabel = UILabel()
        
        fullLinkLabel.text = fullLink
        
        fullLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(fullLinkLabel)
        
        NSLayoutConstraint.activate([
            fullLinkLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            fullLinkLabel.topAnchor.constraint(equalTo: topAnchor, constant: 23),
            deleteButton.leadingAnchor.constraint(equalTo: fullLinkLabel.trailingAnchor, constant: 20)])
    }
    
    private func addSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .inactive
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separator)
        
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
        shortenedLinkLabel.text = shortenedLink
        shortenedLinkLabel.textColor = .lightBlue
        shortenedLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shortenedLinkLabel)
        
        NSLayoutConstraint.activate([
            shortenedLinkLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 12),
            shortenedLinkLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            trailingAnchor.constraint(equalTo: shortenedLinkLabel.trailingAnchor, constant: 23)
        ])
        
        return shortenedLinkLabel
    }
    
    private func addCopyButton(shortenedLinkLabel: UIView) {
        let copyButton = TemporaryStateChangingButton()
        copyButton.setTitle("COPY", for: .normal)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        
        copyButton.addTarget(self, action: #selector(copyButtonDidTap(_:)), for: .touchUpInside)
        
        addSubview(copyButton)
        
        NSLayoutConstraint.activate([
            copyButton.topAnchor.constraint(equalTo: shortenedLinkLabel.bottomAnchor, constant: 23),
            copyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            trailingAnchor.constraint(equalTo: copyButton.trailingAnchor, constant: 23),
            bottomAnchor.constraint(equalTo: copyButton.bottomAnchor, constant: 23),
            copyButton.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
    
    @objc private func deleteButtonDidTap() {
        onDelete?()
    }
    
    @objc private func copyButtonDidTap(_ button: TemporaryStateChangingButton) {
        onCopy?(button)
    }
}
