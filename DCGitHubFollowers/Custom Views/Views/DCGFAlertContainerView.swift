//
//  DCGFAlertContainerView.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 30/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

class DCGFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor       = .systemBackground
        layer.cornerRadius    = 16
        layer.borderWidth     =  2
        layer.borderColor     = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
