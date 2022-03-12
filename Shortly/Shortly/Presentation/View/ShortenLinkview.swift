//
//  ShortenLinkview.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import UIKit

final class ShortenLinkview: UIView {
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .darkPurple
        addShape()
        let textField = addTextField()
        addButton(textField: textField)
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
            shapeImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 47.0/34.0)
        ])
    }
    
    private func addTextField() -> UIView {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 46),
            trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 48),
            textField.heightAnchor.constraint(equalToConstant: 49)
        ])
        
        return textField
    }
    
    private func addButton(textField: UIView) {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 48),
            button.heightAnchor.constraint(equalToConstant: 49)
        ])
    }
}
