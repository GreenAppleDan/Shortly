//
//  ContainerViewController.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import UIKit

class ContainerViewController: UIViewController {
    
    /// controller with content
    private(set) var contentViewController: UIViewController?
    
    // MARK: - Content
    
    /// Setting new content
    ///
    ///  - Parameters:
    ///   - content: Controller with new content
    ///   - animated: Should animate adding of new content
    func setContent(_ content: UIViewController?, animated: Bool) {
        
        guard content != contentViewController else { return }
        
        if content == nil, contentViewController == nil {
            return
        }
        
        if animated {
            transition(from: contentViewController, to: content)
        } else {
            contentViewController?.removeChildFromParent()
            if let content = content {
                addChildViewController(content, to: view)
            }
        }
        
        contentViewController = content
        
        if !animated {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: - Private
    
    private func transition(
        from currentViewController: UIViewController?,
        to newViewController: UIViewController?) {
            
            currentViewController?.willMove(toParent: nil)
            currentViewController?.beginAppearanceTransition(false, animated: true)
            currentViewController?.view.removeFromSuperview()
            
            if let newViewController = newViewController {
                addChild(newViewController)
                newViewController.beginAppearanceTransition(true, animated: true)
                newViewController.view.pin(to: view)
            }
            
            UIView.transition(
                with: view,
                duration: 0.2,
                options: .transitionCrossDissolve,
                animations: {
                    self.setNeedsStatusBarAppearanceUpdate()
                },
                completion: { _ in
                    currentViewController?.endAppearanceTransition()
                    currentViewController?.removeFromParent()
                    
                    newViewController?.endAppearanceTransition()
                    newViewController?.didMove(toParent: self)
                })
        }
}
