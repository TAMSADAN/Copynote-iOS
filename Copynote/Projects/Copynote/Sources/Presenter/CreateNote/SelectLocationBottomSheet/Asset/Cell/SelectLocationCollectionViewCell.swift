//
//  SelectLocationCollectionViewCell.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/24.
//  Copyright © 2023 Copynote. All rights reserved.
//

import UIKit
import ReactorKit

class SelectLocationCollectionViewCell: BaseCollectionViewCell, View {
    // MARK: - Properties
    
    typealias Reactor = SelectLocationCollectionViewCellReactor
    
    // MARK: - UI Components
    
    let imageView: UIImageView = .init()
    let titleLabel: UILabel = .init()
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        imageView.image = .init(systemName: "checkmark.circle")
        imageView.tintColor = .black
        imageView.isHidden = true
        
        titleLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 18)
        titleLabel.textColor = .black
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([imageView, titleLabel])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    
    func bind(reactor: Reactor) {
        titleLabel.text = reactor.initialState.location.name
        
        if reactor.initialState.isSelected {
            imageView.isHidden = false
            titleLabel.font = CopynoteFontFamily.HappinessSansPrint.bold.font(size: 18)
        } else {
            imageView.isHidden = true
            titleLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 18)
        }
    }

}
