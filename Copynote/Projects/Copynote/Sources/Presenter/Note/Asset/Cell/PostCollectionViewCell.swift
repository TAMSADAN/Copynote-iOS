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
    
    let kindLabel: UILabel = .init()
    let titleLabel: UILabel = .init()
    let contentLabel: UILabel = .init()
    let button: UIButton = .init(type: .system)

    override func setupProperty() {
        super.setupProperty()
        
        contentView.makeBorder(color: .black, width: 1)
        contentView.cornerRound(radius: 10)
        
        kindLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 10)
        
        titleLabel.font = CopynoteFontFamily.HappinessSansPrint.bold.font(size: 17)
        
        contentLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 14)
        
        button.setTitle("Copy", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = CopynoteFontFamily.HappinessSansPrint.title.font(size: 10)
        button.cornerRound(radius: 12)
        
        kindLabel.text = "Memo"
        titleLabel.text = "타이틀입니다."
        contentLabel.text = "본문입니다."
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        contentView.addSubviews([kindLabel, titleLabel, contentLabel, button])
    }
    
    override func setupLayout() {
        super.setupLayout()

        kindLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(kindLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(15)
        }
        
        button.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(titleLabel)
            $0.height.equalTo(30)
            $0.width.equalTo(40)
        }
    }
    
    func bind(reactor: Reactor) {

    }
}
