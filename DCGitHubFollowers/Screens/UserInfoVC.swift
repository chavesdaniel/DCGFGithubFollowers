//
//  UserInfoVC.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 26/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor                = .systemBackground
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem   = doneButton
        
        layoutUI()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let user):
                
                DispatchQueue.main.async {
                    self.add(childVC: DCGFUserInfoHeaderVC(user: user), to: self.headerView)
                }
                
                break
            case .failure(let error):
                self.presentDCGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTittle: "OK")
                break
                
            }
        }
    }
    
    
    func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
            
        ])
        
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    

}
