//
//  DCGFEmptyView.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 26/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

class DCGFEmptyView: UIView {

    let messageLabel    = DCGFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView   = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    private func configure() {
        configureLogoImage()
        configureMessageLabel()
    }
    
    
    private func configureLogoImage() {
        addSubview(logoImageView)
        
        logoImageView.image                     = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoBottomConstant: CGFloat         = DevicesType.isiPhoneSE || DevicesType.isiPhone8Zoomed ? 80 : 40
        let logoImageViewBottomContraint        = logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
        logoImageViewBottomContraint.isActive   = true
        
        NSLayoutConstraint.activate([
            
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
            logoImageViewBottomContraint
        ])
    }
    
    
    private func configureMessageLabel() {
        addSubview(messageLabel)
        
        messageLabel.numberOfLines              = 3
        messageLabel.textColor                  = .secondaryLabel
        
        let labelCenterYConstant: CGFloat       = DevicesType.isiPhoneSE || DevicesType.isiPhone8Zoomed ? -80 : -150
        let messageLabelCenterYConstraint       = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        messageLabelCenterYConstraint.isActive  = true
        
        NSLayoutConstraint.activate([
            messageLabelCenterYConstraint,
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
}
