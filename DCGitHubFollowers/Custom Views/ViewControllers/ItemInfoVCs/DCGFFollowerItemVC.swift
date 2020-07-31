//
//  DCGFFollowerItemVC.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 27/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import Foundation

protocol DCGFFollowerItemVCVCDelegate: class {
    func didTapGetFollowers(for user: User)
}

class DCGFFollowerItemVC: DCGFItemInfoVC {
    
    weak var delegate: DCGFFollowerItemVCVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureItems()
    }
    
    
    init(user: User, delegate: DCGFFollowerItemVCVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
