//
//  LogoViewController.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit

class LogoViewController: BaseViewController {
    // MARK: - UI Components

    let logoView: UIView = .init()
    let logoLabel: UILabel = .init()
    let contentView: UIView = .init()
    
    override func setupProperty() {
        super.setupProperty()
        
        logoLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 16)
        logoLabel.text = "copy note ."
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(<#T##view: UIView##UIView#>)
    }
}
