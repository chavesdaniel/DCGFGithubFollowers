//
//  FollowerListVC.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 24/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowerListVC: DCGFDataLodingVC {
    
    enum Section { case main }
    
    var username                    : String!
    var followers                   : [Follower] = []
    var filteredFollowers           : [Follower] = []
    var page                        = 1
    var hasMoreFollowers            = true
    var isSearching                 = false
    var isSearchingForMoreFollowers = false
    
    var collectionView              : UICollectionView!
    var dataSource                  : UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username               = username
        title                       = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let plusButton                      = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem   = plusButton
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "search username"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
        
    }
    
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        isSearchingForMoreFollowers = true
        NetworkManager.shared.getFollowers(for: username, page: page, completed: { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
            case .failure(let error):
                self.presentDCGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTittle: "OK")
                break
            }
            
            self.isSearchingForMoreFollowers = false
            
        })
    }
    
    
    func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them 😀."
            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
            return
        }
        
        self.updateData(on: self.followers)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    
    @objc func addButtonTapped() {
        
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                self.addUserToFavorites(user: user)
            case .failure(let err):
                self.presentDCGFAlertOnMainThread(title: "Something went wrong", message: err.rawValue, buttonTittle: "Ok")
            }
        }
    }
    
    func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] err in
            guard let self = self else { return }
            
            guard let err = err else {
                self.presentDCGFAlertOnMainThread(title: "Success", message: "You have successfully favored this user 🎉.", buttonTittle: "Hooray!")
                return
            }
            
            self.presentDCGFAlertOnMainThread(title: "Something went wrong", message: err.rawValue, buttonTittle: "OK")
        }
    }
}


extension FollowerListVC: UICollectionViewDelegate {
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY             = scrollView.contentOffset.y
        let contentHight        = scrollView.contentSize.height
        let height              = scrollView.frame.size.height
        
        if offsetY > contentHight - height {
            guard hasMoreFollowers, !isSearchingForMoreFollowers else { return }
            
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray     = isSearching ? filteredFollowers : followers
        let follower        = activeArray[indexPath.item]
        
        let destVC          = UserInfoVC()
        destVC.username     = follower.login
        destVC.delegate     = self
        let navController   = UINavigationController(rootViewController: destVC)
        
        present(navController, animated: true)
    }
    
}

extension FollowerListVC: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text,
            !filter.isEmpty else {
                filteredFollowers.removeAll()
                updateData(on: followers)
                isSearching = false
                return
                
        }
        isSearching         = true
        filteredFollowers   = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        
        updateData(on: filteredFollowers)
    }
    

}

extension FollowerListVC: UserInfoVCDelegate {
    
    
    func didRequestFollowers(for username: String) {
        self.username   = username
        title           = username
        page            = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item:0 , section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
    
    
}
