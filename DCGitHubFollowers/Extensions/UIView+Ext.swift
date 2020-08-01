//
//  UIView+Ext.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 31/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

extension UIView {
    
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
    
    
    func pinToEdges(of superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo:      superView.topAnchor),
            self.leadingAnchor.constraint(equalTo:  superView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo:   superView.bottomAnchor)
        ])
    }
    
    
}
