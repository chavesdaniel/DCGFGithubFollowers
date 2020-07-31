//
//  DCGFRepoItemVC.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 27/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

class DCGFRepoItemVC: DCGFItemInfoVC {
    
    
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
