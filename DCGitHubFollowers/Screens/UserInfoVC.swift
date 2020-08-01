//
//  UserInfoVC.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 26/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {
    
    let scrollView              = UIScrollView()
    let contentView             = UIView()
    
    let headerView              = UIView()
    let itemViewOne             = UIView()
    let itemViewTwo             = UIView()
    let dateLabel               = DCGFBodyLabel(textAlignment: .center)

    var itemViews: [UIView]     = []
    var username: String!
    weak var delegate:          UserInfoVCDelegate!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    
    func configureViewController() {
        view.backgroundColor                = .systemBackground
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem   = doneButton
    }
    
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElementsWith(user: user) }
                break
            case .failure(let error):
                self.presentDCGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTittle: "OK")
                break
                
            }
        }
    }
    
    
    func configureUIElementsWith(user: User) {
        
        self.add(childVC: DCGFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: DCGFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.add(childVC: DCGFUserInfoHeaderVC(user: user), to: self.headerView)
        
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    
    func layoutUI() {
        itemViews               = [headerView, itemViewOne, itemViewTwo, dateLabel]
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
                
            ])
        }
                
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}

extension UserInfoVC: DCGFRepoItemVCDelegate {
    
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentDCGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTittle: "Ok")
            return
        }
        self.presentSafariVC(with: url)
    }
    
    
}


extension UserInfoVC: DCGFFollowerItemVCVCDelegate {
    
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentDCGFAlertOnMainThread(title: "No followers", message: "This user has no followers. What a shame 😞", buttonTittle: "So sad")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    

}
