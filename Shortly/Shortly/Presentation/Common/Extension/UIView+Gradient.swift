//
//  UIView+Gradient.swift
//  Shortly
//
//  Created by Denis on 14.03.2022.
//

import UIKit

extension UIView {
    @discardableResult
    func applyGradient(
        topColor: UIColor,
        bottomColor: UIColor) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [topColor, bottomColor].map { $0.cgColor }
        gradient.startPoint = .init(x: 0.5, y: 0)
        gradient.endPoint = .init(x: 0.5, y: 1)
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}
