//
//  InvalidatableTextField.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import UIKit

class InvalidatableTextField: UITextField {
    
    private(set) var isInvalid = false
    
    private var errorText: String? = nil
    private var defaultPlaceholderText: String? = nil
    
    private let textPadding = UIEdgeInsets(
            top: 0,
            left: 10,
            bottom: 0,
            right: 10
        )
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        self.defaultPlaceholderText = placeholder
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    private func commonInit() {
        textAlignment = .center
        adjustsFontForContentSizeCategory = true
        setCorners(4)
        backgroundColor = .white
        updateColors()
        updateBorderWidth()
    }
    
    private func updateBorderWidth() {
        layer.borderWidth = isInvalid ? 2 : 0
    }
    
    private func updateColors() {
        layer.borderColor = isInvalid ? UIColor.error.cgColor : nil
        
        let placeholderColor: UIColor = isInvalid ? .error : .inactive
        
        var placeholderText: String {
            if isInvalid {
                return errorText ?? ""
            } else {
                return defaultPlaceholderText ?? placeholder ?? ""
            }
        }
        
        attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        
        textColor = isInvalid ? .error : .black
    }
    
    func markAsInvalid(errorText: String? = nil) {
        self.errorText = errorText
        isInvalid = true
        updateColors()
        updateBorderWidth()
    }
    
    func markAsValid() {
        isInvalid = false
        updateColors()
        updateBorderWidth()
    }
}
