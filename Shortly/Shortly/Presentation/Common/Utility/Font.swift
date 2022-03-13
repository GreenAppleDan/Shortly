//
//  Font.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import UIKit

enum PoppinsType: String {
    case bold = "Poppins-Bold"
    case medium = "Poppins-Medium"
}

extension UIFont {
    
    static func poppins(type: PoppinsType, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.rawValue, size: size) else {
            return .systemFont(ofSize: size)
        }
        
        return font
    }
}
