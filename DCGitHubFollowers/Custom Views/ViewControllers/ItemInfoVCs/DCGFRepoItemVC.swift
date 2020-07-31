//
//  DCGFRepoItemVC.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 27/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

protocol DCGFRepoItemVCDelegate: class {
    func didTapGitHubProfile(for user: User)
}


class DCGFRepoItemVC: DCGFItemInfoVC {
    
    weak var delegate       : DCGFRepoItemVCDelegate!
    
    
    init(user: User, delegate: DCGFRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    
    override func actionButtonTapped() {
        delegate!.didTapGitHubProfile(for: user)
    }
    
}
