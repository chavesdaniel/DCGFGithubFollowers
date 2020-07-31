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
}
