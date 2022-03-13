//
//  ShortenLinkview.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import UIKit

protocol ShortenLinkviewDelegate: AnyObject {
    func shortenLinkTextFieldTextDidChange(textField: InvalidatableTextField)
    func shortenLinkButtonDidTap(textField: InvalidatableTextField)
}

final class ShortenLinkview: UIView {
    
    private weak var delegate: ShortenLinkviewDelegate?
    
    lazy var textField = InvalidatableTextField(placeholder: "Shorten a link here ...")
    lazy var button = SimpleButton()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .darkPurple
        addBackgroundView()
        addShape()
        addTextField()
        addButton(textField: textField)
    }
    
    private func addBackgroundView() {
        let view = UIView()
        view.backgroundColor = .darkPurple
        view.pin(to: self)
    }
    
    private func addShape() {
        let shapeImageView = UIImageView()
        shapeImageView.image = #imageLiteral(resourceName: "shape")
        shapeImageView.contentMode = .redraw
        
        shapeImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shapeImageView)
        
        NSLayoutConstraint.activate([
            shapeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shapeImageView.topAnchor.constraint(equalTo: topAnchor),
            shapeImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 47/34)
        ])
    }
    
    private func addTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 46),
            trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 48),
            textField.heightAnchor.constraint(equalToConstant: 49)
        ])
    }
    
    private func addButton(textField: UIView) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SHORTEN IT!", for: .normal)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 48),
            button.heightAnchor.constraint(equalToConstant: 49)
        ])
    }
}
