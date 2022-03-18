//
//  SavedLinkTableViewCell.swift
//  Shortly
//
//  Created by Denis on 18.03.2022.
//

import UIKit


final class SavedLinkTableViewCell: UITableViewCell {
    
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
                   shortenedLink: String) {
        contentView.isUserInteractionEnabled = false
        configureDeleteButton()
        configureFullLinkLabel(fullLink: fullLink)
        configureSeparator()
        configureShortenedLinkLabel(shortenedLink: shortenedLink)
        configureCopyButton()
    }
    
    // MARK: - Private
    private func setupUI() {
        addDeleteButton()
        addFullLinkLabel()
        addSeparator()
        addShortenedLinkLabel()
        addCopyButton()
    }
    
    private func addDeleteButton() {
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            deleteButton.heightAnchor.constraint(equalToConstant: 18),
            deleteButton.widthAnchor.constraint(equalToConstant: 14),
            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            trailingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 26)])
    }
    
    private func addFullLinkLabel() {
        fullLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(fullLinkLabel)
        
        NSLayoutConstraint.activate([
            fullLinkLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            fullLinkLabel.topAnchor.constraint(equalTo: topAnchor, constant: 23),
            deleteButton.leadingAnchor.constraint(equalTo: fullLinkLabel.trailingAnchor, constant: 20)])
    }
    
    private func addSeparator() {
        separator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separator)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.topAnchor.constraint(equalTo: topAnchor, constant: 57)
        ])
    }
    
    private func addShortenedLinkLabel() {
        shortenedLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shortenedLinkLabel)
        
        NSLayoutConstraint.activate([
            shortenedLinkLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 12),
            shortenedLinkLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            trailingAnchor.constraint(equalTo: shortenedLinkLabel.trailingAnchor, constant: 23)
        ])
    }
    
    private func addCopyButton() {
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(copyButton)
        
        NSLayoutConstraint.activate([
            copyButton.topAnchor.constraint(equalTo: shortenedLinkLabel.bottomAnchor, constant: 23),
            copyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            trailingAnchor.constraint(equalTo: copyButton.trailingAnchor, constant: 23),
            bottomAnchor.constraint(equalTo: copyButton.bottomAnchor, constant: 23),
            copyButton.heightAnchor.constraint(equalToConstant: 39)
        ])
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
