//
//  PostCollectionViewHeader.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import ReactorKit

class PostCollectionViewHeader: BaseCollectionReusableView, View {
    // MARK: - Properties
    typealias Reactor = PostCollectionViewHeaderReactor
    
    // MARK: - UI Components
    
    let kindStackView: KindStackView = .init()
    
    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([kindStackView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundColor = .white
        
        kindStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    func bind(reactor: Reactor) {
        kindStackView.update(kinds: reactor.currentState.kinds)
    }
}
