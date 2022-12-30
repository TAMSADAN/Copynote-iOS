//
//  NoteCollectionViewCell.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit
import ReactorKit

class PostCollectionViewCell: BaseCollectionViewCell, View {
    // MARK: - Properties

    typealias Reactor = PostCollectionViewCellReactor

    // MARK: - UI Components

    let titleLabel: UILabel = .init()

    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 18)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        contentView.addSubviews([titleLabel])
    }
    
    override func setupLayout() {
        super.setupLayout()

        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        titleLabel.text = ""
    }
}
