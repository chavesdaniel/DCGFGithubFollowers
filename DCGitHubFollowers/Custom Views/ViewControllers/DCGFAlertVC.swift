//
//  DCGFAlertVC.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 24/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

class DCGFAlertVC: UIViewController {

    let containerView       = DCGFAlertContainerView()
    let titleLable          = DCGFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel        = DCGFBodyLabel(textAlignment: .left)
    let actionButton        = DCGFButton(backgroundColor: .systemPink, title: "OK")
        
    var alertTitle          : String?
    var message             : String?
    var buttonTitle         : String?
    let padding             : CGFloat = 20
    
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    
    func configureContainerView() {
        view.addSubviews(containerView, titleLable)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    
    func configureTitleLabel() {
        titleLable.text = alertTitle ?? "!! Title not configured !!"
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo:            containerView.topAnchor, constant: padding),
            titleLable.leadingAnchor.constraint(equalTo:        containerView.leadingAnchor, constant: padding),
            titleLable.trailingAnchor.constraint(equalTo:       containerView.trailingAnchor, constant: -padding),
            titleLable.heightAnchor.constraint(equalToConstant: 28)
            
        ])
    }
    
    
    func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo:       containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo:      containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo:     containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text           = message ?? "!! Message has note been set !!"
        messageLabel.numberOfLines  = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo:          titleLable.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo:      containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo:     containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo:       actionButton.topAnchor, constant: -12)
        ])
    }
    
    
    @objc func dismissVC() {
        self.dismiss(animated: true)
    }
    
    
}
