//
//  PostCollectionViewHeader.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit
import ReactorKit

class PostCollectionViewHeader: BaseCollectionReusableView, View {
    // MARK: - Properties
    typealias Reactor = PostCollectionViewHeaderReactor
    
    // MARK: - UI Components
    
    private let stackView: UIStackView = .init()
    var kindButtons: [UIButton] = []
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        stackView.removeArrangedSubviews()
        kindButtons = []
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        stackView.spacing = 10
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(stackView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundColor = .white
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    func bind(reactor: Reactor) {
        reactor.initialState.kinds.forEach({ kind in
            let button = UIButton(type: .system)
            
            if kind == reactor.initialState.selectedKind {
                button.backgroundColor = .black
                button.titleLabel?.font = CopynoteFontFamily.HappinessSansPrint.bold.font(size: 13)
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .white
                button.titleLabel?.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 13)
                button.setTitleColor(.black, for: .normal)
            }
            
            button.cornerRound(radius: 10)
            button.makeBorder(color: .black, width: 1)
            button.setTitle(kind.title, for: .normal)
            
            kindButtons.append(button)
            
            button.snp.makeConstraints {
                $0.width.equalTo(50)
                $0.height.equalTo(25)
            }
            
            stackView.addArrangedSubview(button)
        })
    }
}
