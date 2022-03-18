//
//  SavedLinkTableViewCell.swift
//  Shortly
//
//  Created by Denis on 18.03.2022.
//

import UIKit


final class SavedLinkTableViewCell: UITableViewCell {
    
    private let mainContainer = UIView()
    private let deleteButton = UIButton()
    private let fullLinkLabel = UILabel()
    private let separator = UIView()
    private let shortenedLinkLabel = UILabel()
    private let copyButton = TemporaryStateChangingButton()
    
    var onDelete: (() -> Void)?
    var onCopy: ((TemporaryStateChangingButton) -> Void)?
    
    static let identifier = String(describing: SavedLinkTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    func configure(fullLink: String,
                   shortenedLink: String,
                   backgroundColor: UIColor) {
        self.backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        configureMainContainer(backgroundColor: backgroundColor)
        configureDeleteButton()
        configureFullLinkLabel(fullLink: fullLink)
        configureSeparator()
        configureShortenedLinkLabel(shortenedLink: shortenedLink)
        configureCopyButton()
    }
    
    // MARK: - Private
    private func setupUI() {
        addMainContainer()
        addDeleteButton()
        addFullLinkLabel()
        addSeparator()
        addShortenedLinkLabel()
        addCopyButton()
    }
    
    private func addMainContainer() {
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainContainer)
        
        NSLayoutConstraint.activate([
            mainContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            mainContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            mainContainer.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            mainContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func addDeleteButton() {
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            deleteButton.heightAnchor.constraint(equalToConstant: 18),
            deleteButton.widthAnchor.constraint(equalToConstant: 14),
            deleteButton.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 24),
            mainContainer.trailingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 26)])
    }
    
    private func addFullLinkLabel() {
        fullLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(fullLinkLabel)
        
        NSLayoutConstraint.activate([
            fullLinkLabel.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 23),
            fullLinkLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 23),
            deleteButton.leadingAnchor.constraint(equalTo: fullLinkLabel.trailingAnchor, constant: 20)])
    }
    
    private func addSeparator() {
        separator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separator)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            separator.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 57)
        ])
    }
    
    private func addShortenedLinkLabel() {
        shortenedLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shortenedLinkLabel)
        
        NSLayoutConstraint.activate([
            shortenedLinkLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 12),
            shortenedLinkLabel.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 23),
            mainContainer.trailingAnchor.constraint(equalTo: shortenedLinkLabel.trailingAnchor, constant: 23)
        ])
    }
    
    private func addCopyButton() {
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(copyButton)
        
        NSLayoutConstraint.activate([
            copyButton.topAnchor.constraint(equalTo: shortenedLinkLabel.bottomAnchor, constant: 23),
            copyButton.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 23),
            mainContainer.trailingAnchor.constraint(equalTo: copyButton.trailingAnchor, constant: 23),
            mainContainer.bottomAnchor.constraint(equalTo: copyButton.bottomAnchor, constant: 23),
            copyButton.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
    
    private func configureMainContainer(backgroundColor: UIColor) {
        mainContainer.backgroundColor = backgroundColor
        mainContainer.setCorners(4)
    }
    
    private func configureDeleteButton() {
        let image = #imageLiteral(resourceName: "del")
        deleteButton.setImage(image, for: .normal)
        
        deleteButton.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
    }
    
    private func configureFullLinkLabel(fullLink: String) {
        fullLinkLabel.font = .poppins(type: .medium, size: 17)
        fullLinkLabel.text = fullLink
    }
    
    private func configureSeparator() {
        separator.backgroundColor = .inactive
    }
    
    private func configureShortenedLinkLabel(shortenedLink: String) {
        shortenedLinkLabel.font = .poppins(type: .medium, size: 17)
        shortenedLinkLabel.text = shortenedLink
        shortenedLinkLabel.textColor = .lightBlue
    }
    
    private func configureCopyButton() {
        copyButton.setTitle("COPY", for: .normal)
        copyButton.addTarget(self, action: #selector(copyButtonDidTap(_:)), for: .touchUpInside)
    }
    
    @objc private func deleteButtonDidTap() {
        onDelete?()
    }
    
    @objc private func copyButtonDidTap(_ button: TemporaryStateChangingButton) {
        onCopy?(button)
    }
}
