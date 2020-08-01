//
//  UITableView+Ext.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 31/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit


extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    func removeExcessesCells() {
        tableFooterView = UIView(frame: .zero)
        
    }
    
}
