//
//  LinkListTitleTableViewCell.swift
//  Shortly
//
//  Created by Denis on 18.03.2022.
//

import UIKit

final class LinkListTitleTableViewCell: UITableViewCell {
    
    private let label = UILabel()
    
    static let identifier = String(describing: LinkListTitleTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func setup() {
        label.pin(to: self)
    }
    
    func configure (title: String) {
        label.text = title
        label.textAlignment = .center
        label.font = .poppins(type: .medium, size: 17)
    }
}
