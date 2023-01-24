//
//  SettingView.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import UIKit

class SettingView: BaseView {
    // MARK: - UI Components
    
    let leadingImageView: UIImageView = .init()
    let titleLabel: UILabel = .init()
    let trailingImageView: UIImageView = .init()
    
    // MARK: - Initializer
    
    init(image: UIImage?, title: String?) {
        super.init(frame: .zero)
        
        leadingImageView.image = image
        titleLabel.text = title
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        leadingImageView.tintColor = .black
        leadingImageView.contentMode = .scaleAspectFit
        
        titleLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 15)
        
        trailingImageView.tintColor = .black
        trailingImageView.image = UIImage(systemName: "chevron.right")
        trailingImageView.contentMode = .scaleAspectFit
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([leadingImageView, titleLabel, trailingImageView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        leadingImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(leadingImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        
        trailingImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(15)
            $0.height.equalTo(15)
        }
    }
}
