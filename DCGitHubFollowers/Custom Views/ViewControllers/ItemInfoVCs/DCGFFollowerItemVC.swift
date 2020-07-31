//
//  DCGFFollowerItemVC.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 27/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import Foundation

class DCGFFollowerItemVC: DCGFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
