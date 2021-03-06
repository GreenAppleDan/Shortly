//
//  SimpleButton.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import UIKit

class SimpleButton: LoadableButton {
    
    var defaultBackgroundColor: UIColor { .lightBlue }
    
    convenience init() {
        self.init(type: .custom)
        commonInit()
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        isExclusiveTouch = true
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.font = .poppins(type: .bold, size: 20)
        clipsToBounds = true
        setCorners(4)
        setColors()
    }
    
    private func setColors() {
        backgroundColor = defaultBackgroundColor
    }
}
