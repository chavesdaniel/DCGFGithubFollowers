//
//  FavoriteCell.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 29/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID  = "FavoriteCell"
    let avatarImageView = DCGFAvatarImageView(frame: .zero)
    let usernameLabel   = DCGFTitleLabel(textAlignment: .left, fontSize: 26)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        avatarImageView.downloadImage(fromURL: favorite.avatarUrl)
    }
    
    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)
        
        accessoryType           = .disclosureIndicator
        let padding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo:           self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo:           leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant:    60),
            avatarImageView.widthAnchor.constraint(equalToConstant:     60),
            
            usernameLabel.centerYAnchor.constraint(equalTo:             self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo:             avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo:            trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant:      40)
            
        ])
    }
    
    
}
