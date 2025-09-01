//
//  UserListViewController.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 31.08.2025.
//

import UIKit

final class UserListViewController: BaseViewController, UserListViewInput {
    
    var output: UserListViewOutput?
    
    private var collectionView: UICollectionView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var dataSource: UICollectionViewDiffableDataSource<Int, UserListCellModel>!
    private let layout: Layout = .init()
    private lazy var errorView: ErrorView = .build()
    private lazy var activityIndicator: UIActivityIndicatorView = .build {
        $0.style = .large
        $0.color = .systemPurple
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    override func addUI() {
        super.addUI()
        addSearchController()
        addCollectionView()
        addDataSource()
        addStateViews()
        addActivityIndicator()
    }
    
    func displayInitialState(with data: UserListViewData) {
        title = data.title
        searchController.searchBar.placeholder = data.searchPlaceholder
    }
    
    func displayLoading(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
            collectionView.isHidden = true
        } else {
            activityIndicator.stopAnimating()
            collectionView.isHidden = false
        }
    }
    
    func bind(results: [UserListCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, UserListCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(results, toSection: 0)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func displayError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
        //        TODO: errorView.bind(ErrorPresentationModel(title: title, message: message))
    }
}

private extension UserListViewController {
    func addStateViews() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

private extension UserListViewController {
    
    func addSearchController() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func addCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: layout.cellIdentifier)
    }
    
    func addDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, UserListCellModel>(collectionView: collectionView) {
            [weak self] (collectionView, indexPath, cellModel) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self?.layout.cellIdentifier ?? "", for: indexPath) as? UserCell else {
                fatalError("Cannot create UserCell")
            }
            
            cell.bind(with: cellModel)
            cell.onFavoriteButtonTapped = {
                self?.output?.favoriteButtonTapped(for: cellModel)
            }
            return cell
        }
    }
    
    func addActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(layout.itemWidthFractional), heightDimension: .estimated(layout.itemEstimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(layout.groupWidthFractional), heightDimension: .estimated(layout.groupEstimatedHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        group.interItemSpacing = .fixed(layout.interItemSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = layout.interGroupSpacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: layout.contentInsets.top,
            leading: layout.contentInsets.leading,
            bottom: layout.contentInsets.bottom,
            trailing: layout.contentInsets.trailing
        )
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension UserListViewController: UICollectionViewDelegate, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text ?? ""
        output?.searchButtonTapped(with: query)
        searchBar.resignFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellModel = dataSource.itemIdentifier(for: indexPath) else { return }
        output?.didSelectUser(with: cellModel)
    }
}

private extension UserListViewController {
    private struct Layout {
        let contentInsets: NSDirectionalEdgeInsets = .init(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
        let itemWidthFractional: CGFloat = 0.5
        let itemEstimatedHeight: CGFloat = 180
        let groupWidthFractional: CGFloat = 1.0
        let groupEstimatedHeight: CGFloat = 180
        let groupItemCount: Int = 2
        let interItemSpacing: CGFloat = 16
        let interGroupSpacing: CGFloat = 16
        let cellIdentifier: String = "UserCell"
    }
}
