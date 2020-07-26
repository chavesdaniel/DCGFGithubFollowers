//
//  DCGFSecondaryTitleLabel.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 26/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

class DCGFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font                        = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    private func configure() {
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
