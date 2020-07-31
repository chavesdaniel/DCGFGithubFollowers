//
//  UIViewController+Ext.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 24/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentDCGFAlertOnMainThread(title: String, message: String, buttonTittle: String) {
        DispatchQueue.main.async {
            let alertVC = DCGFAlertVC(title: title, message: message, buttonTitle: buttonTittle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentSafariVC(with url:URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
}
