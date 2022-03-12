//
//  UIViewController+Child.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import UIKit

extension UIViewController {
    
    func addChildViewController(_ child: UIViewController, to container: UIView) {
        addChild(child)
        child.view.pin(to: container)
        child.didMove(toParent: self)
    }
    
    func removeChildFromParent() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
