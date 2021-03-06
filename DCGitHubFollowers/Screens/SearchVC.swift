//
//  SearchVC.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 23/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView               = UIImageView()
    let usernameTextField           = DCGFTextField()
    let callToActionButton          = DCGFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool { !usernameTextField.text!.isEmpty }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor    = .systemBackground
        configureLogoImageView()
        configureUsernameTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(pushFollowerListVC))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowerListVC() {
        guard isUsernameEntered else {
            presentDCGFAlertOnMainThread(title: "Empy Username", message: "Please enter a username. We need to know who to look for 😀.", buttonTittle: "OK")
            return
        }
        usernameTextField.resignFirstResponder()
        
        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image                 = Images.ghLogo
        
        let topConstraintConstant: CGFloat  = DevicesType.isiPhoneSE || DevicesType.isiPhone8Zoomed ? 20: 80
        
        
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo:             view.safeAreaLayoutGuide.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant:      200),
            logoImageView.widthAnchor.constraint(equalToConstant:       200)
        ])
    }
    
    
    func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo:             logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo:         view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo:        view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant:  50)
        ])
    }
    
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo:         view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo:        view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo:       view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
    
    
}
