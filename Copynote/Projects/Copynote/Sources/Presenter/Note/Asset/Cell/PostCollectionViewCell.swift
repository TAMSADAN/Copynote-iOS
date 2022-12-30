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
    let contentLabel: UILabel = .init()

    override func setupProperty() {
        super.setupProperty()
        
        contentView.makeBorder(color: .black, width: 1)
        contentView.cornerRound(radius: 10)
        
        titleLabel.font = CopynoteFontFamily.HappinessSansPrint.bold.font(size: 18)
        
        contentLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 15)
        
        titleLabel.text = "타이틀입니다."
        contentLabel.text = "본문입니다."
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        contentView.addSubviews([titleLabel, contentLabel])
    }
    
    override func setupLayout() {
        super.setupLayout()

        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(15)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {

    }
}
