//
//  TemporaryStateChangingButton.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import UIKit

class TemporaryStateChangingButton: SimpleButton {
    
    struct Properties {
        let backgroundColor: UIColor
        let text: String
    }
    
    func changeProperties(properties: Properties, for seconds: Double) {
        isUserInteractionEnabled = false
        let originalBackgroundColor = backgroundColor
        let originalText = titleLabel?.text
        
        backgroundColor = properties.backgroundColor
        setTitle(properties.text, for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
            self?.backgroundColor = originalBackgroundColor
            self?.setTitle(originalText, for: .normal)
            self?.isUserInteractionEnabled = true
        }
    }
}
