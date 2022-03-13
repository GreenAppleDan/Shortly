//
//  UIView+Corners.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import UIKit

extension UIView {
    func setCorners(_ cornerRadius: CGFloat) {
        layer.cornerCurve = .continuous
        layer.cornerRadius = cornerRadius
    }
}
