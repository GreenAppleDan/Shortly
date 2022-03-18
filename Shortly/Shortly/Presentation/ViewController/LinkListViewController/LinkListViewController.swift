//
//  LinkListViewController.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import UIKit
import Combine

final class LinkListViewController: UIViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<LinkListSection, ShortenedLinkDataUniqueIdentifiable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<LinkListSection, ShortenedLinkDataUniqueIdentifiable>
    
    private let tableView = UITableView()
    private lazy var dataSource = makeDataSource()
    
    private let shortenedLinksDataProcessor: ShortenedLinksDataProcessor
    private var shortenedLinkSubscription: AnyCancellable?
    
    private var setupDidComplete = false
    
    init(factory: Factory) {
        self.shortenedLinksDataProcessor = factory.makeShortenedLinksDataProcessor()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        setupTableView()
        
        shortenedLinkSubscription = shortenedLinksDataProcessor.shortenedLinkPublisher.sink { [weak self] shortenedLinks in
            self?.applySnapshot(shortenedLinks: shortenedLinks.value)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addGradientView()
    }
    
    private func setupTableView() {
        setupTableViewPosition()
        
        tableView.separatorColor = .clear
        tableView.backgroundColor = .lightGray
        
        tableView.register(LinkListTitleTableViewCell.self, forCellReuseIdentifier: LinkListTitleTableViewCell.identifier)
        tableView.register(SavedLinkTableViewCell.self, forCellReuseIdentifier: SavedLinkTableViewCell.identifier)
        
        applySnapshot(shortenedLinks: [], animatingDifferences: false)
    }
    
    private func setupTableViewPosition() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25)
        ])
    }
    
    private func makeDataSource() -> DataSource {
        
        let dataSource = DataSource(tableView: tableView) { (tableView, indexPath, shortenedLinkData) in
           
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LinkListTitleTableViewCell.identifier, for: indexPath) as? LinkListTitleTableViewCell
                cell?.configure(title: "Your Link History")
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SavedLinkTableViewCell.identifier, for: indexPath) as? SavedLinkTableViewCell
            
            cell?.configure(fullLink: shortenedLinkData.originalLink, shortenedLink: shortenedLinkData.fullShortLink)
            
            cell?.onDelete = { [weak self] in
                self?.shortenedLinksDataProcessor.removeLinkData(shortenedLinkData)
            }
            
            cell?.onCopy = { button in
                UIPasteboard.general.string = shortenedLinkData.fullShortLink
                button.changeProperties(properties: .init(backgroundColor: .darkPurple, text: "COPIED!"), for: 1)
            }

            
            return cell
        }
        
        return dataSource
    }
    
    func applySnapshot(shortenedLinks: [ShortenedLinkDataUniqueIdentifiable], animatingDifferences: Bool = true) {
      var snapshot = Snapshot()
        
      snapshot.appendSections([.main])
      snapshot.appendItems(shortenedLinks)
        
      dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func addGradientView() {
        let gradientView = UIView()
        let height: CGFloat = 65
        gradientView.frame = .init(x: 0, y: view.bounds.height - height, width: view.bounds.width, height: height)
        view.addSubview(gradientView)
        
        gradientView.applyGradient(topColor: .white.withAlphaComponent(0), bottomColor: .lightGray)
        gradientView.isUserInteractionEnabled = false
    }
}
