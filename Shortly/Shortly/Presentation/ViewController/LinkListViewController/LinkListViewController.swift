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
    
    private let tableViewBottomInset: CGFloat = 65
    private let tableViewTopInset: CGFloat = 25
    
    private lazy var titleViewModel = ShortenedLinkDataUniqueIdentifiable(shortenedLinkData: .init(fullShortLink: "", originalLink: ""))
    
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
    
    private func addGradientView() {
        let gradientView = UIView()
        let height: CGFloat = tableViewBottomInset
        gradientView.frame = .init(x: 0, y: view.bounds.height - height, width: view.bounds.width, height: height)
        view.addSubview(gradientView)
        
        gradientView.applyGradient(topColor: .white.withAlphaComponent(0), bottomColor: .lightGray)
        gradientView.isUserInteractionEnabled = false
    }
}

// MARK: - UITableView

extension LinkListViewController {
    
    private func setupTableView() {
        setupTableViewPosition()
        
        tableView.allowsSelection = false
        
        tableView.contentInset.top = tableViewTopInset
        tableView.contentInset.bottom = tableViewBottomInset
        
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.separatorColor = .clear
        tableView.backgroundColor = .lightGray
        
        tableView.register(LinkListTitleTableViewCell.self, forCellReuseIdentifier: LinkListTitleTableViewCell.identifier)
        tableView.register(SavedLinkTableViewCell.self, forCellReuseIdentifier: SavedLinkTableViewCell.identifier)
        
        applySnapshot(shortenedLinks: [], animatingDifferences: false)
    }
    
    private func setupTableViewPosition() {
        tableView.pin(to: view)
    }
    
    private func makeDataSource() -> DataSource {
        
        let dataSource = DataSource(tableView: tableView) { (tableView, indexPath, shortenedLinkData) in
           
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LinkListTitleTableViewCell.identifier, for: indexPath) as? LinkListTitleTableViewCell
                cell?.configure(title: "Your Link History", backgroundColor: .lightGray)
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SavedLinkTableViewCell.identifier, for: indexPath) as? SavedLinkTableViewCell
            
            cell?.configure(
                fullLink: shortenedLinkData.originalLink,
                shortenedLink: shortenedLinkData.fullShortLink,
                backgroundColor: .white)
            
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
        
        var viewModels = [titleViewModel]
        viewModels.append(contentsOf: shortenedLinks)
        
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModels)
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
