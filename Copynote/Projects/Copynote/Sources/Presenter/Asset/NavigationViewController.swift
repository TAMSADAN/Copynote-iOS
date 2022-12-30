//
//  NavigationViewController.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit

class NavigationViewController: BaseViewController {
    // MARK: - UI Components
    
    let barView: UIView = .init()
    let backButton: UIButton = .init()
    let contentView: UIView = .init()
    
    override func setupProperty() {
        super.setupProperty()
        
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = CopynoteFontFamily.HappinessSansPrint.title.font(size: 20)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([barView, contentView])
        barView.addSubviews([backButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        barView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(20)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(barView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
