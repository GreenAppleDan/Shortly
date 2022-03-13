//
//  MainViewController.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let factory: Factory
    private let shortenUrlService: ShortenUrlService
    private let shortenedLinksDataProcessor: ShortenedLinksDataProcessor
    
    private var shortenLinkTextField: InvalidatableTextField!
    private var shortenLinkButton: SimpleButton!
    
    init(factory: Factory) {
        self.factory = factory
        self.shortenUrlService = factory.makeShortenUrlService()
        self.shortenedLinksDataProcessor = factory.makeShortenedLinksDataProcessor()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardActions()
        setup()
    }
    
    private func setup() {
        let shortenLinkView = addShortenLinkView()
        addMainContainerVc(shortenLinkView: shortenLinkView)
    }
    
    private func addShortenLinkView() -> UIView {
        let shortenLinkView = ShortenLinkview()
        
        shortenLinkTextField = shortenLinkView.textField
        shortenLinkButton = shortenLinkView.button
        addTargetsToShortenViews()
        
        shortenLinkView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(shortenLinkView)
        
        NSLayoutConstraint.activate([
            shortenLinkView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shortenLinkView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shortenLinkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            shortenLinkView.heightAnchor.constraint(equalToConstant: 204)
        ])
        
        return shortenLinkView
    }
    
    private func addMainContainerVc(shortenLinkView: UIView) {
        let mainContainerVc = MainContainerViewController(factory: factory)
        addChild(mainContainerVc)
        mainContainerVc.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainContainerVc.view)
        
        NSLayoutConstraint.activate([
            mainContainerVc.view.topAnchor.constraint(equalTo: view.topAnchor),
            mainContainerVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainContainerVc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainContainerVc.view.bottomAnchor.constraint(equalTo: shortenLinkView.topAnchor)
        ])
        
        mainContainerVc.didMove(toParent: self)
    }
    
    private func addTargetsToShortenViews() {
        shortenLinkTextField.addTarget(self, action: #selector(shortenLinkTextFieldDidChange), for: .editingChanged)
        shortenLinkButton.addTarget(self, action: #selector(shortenLinkButtonDidTap), for: .touchUpInside)
    }
    
    private func setupKeyboardActions() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
            .cgRectValue else { return }

        view.frame.origin.y = -keyboardSize.height
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func shortenLinkButtonDidTap() {
        
        dismissKeyboard()
        
        guard let linkString = shortenLinkTextField.text, !linkString.isEmpty else  {
            shortenLinkTextField.markAsInvalid(errorText: "Please add a link here")
            return
        }
        
        shortenLinkButton.showLoading()
        shortenLinkTextField.isUserInteractionEnabled = false
        
        shortenUrlService.shortenUrl(linkString: linkString) { [weak self] result in
            
            self?.shortenLinkButton.hideLoading()
            self?.shortenLinkTextField.isUserInteractionEnabled = true
            
            switch result {
            case .success(let shortenedLinkData):
                self?.shortenedLinksDataProcessor.addLinkData(shortenedLinkData)
            case .failure:
                self?.shortenLinkTextField.markAsInvalid()
            }
            
        }
    }
    
    @objc private func shortenLinkTextFieldDidChange() {
        shortenLinkTextField.markAsValid()
    }
}
