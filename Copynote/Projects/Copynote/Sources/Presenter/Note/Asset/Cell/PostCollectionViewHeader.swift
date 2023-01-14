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
    private var kindButtons: [UIButton] = []
    
    override func setupProperty() {
        super.setupProperty()
        
        stackView.spacing = 10
        
        Kind.allCases.forEach({ kind in
            let button = UIButton(type: .system)
            
            button.cornerRound(radius: 10)
            button.makeBorder(color: .black, width: 1)
            button.setTitle(kind.title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 13)
            
            kindButtons.append(button)
        })
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(stackView)
        
        stackView.addArrangedSubviews(kindButtons)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundColor = .white
        
        kindButtons.forEach({ button in
            button.snp.makeConstraints {
                $0.width.equalTo(50)
                $0.height.equalTo(25)
            }
        })
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    func bind(reactor: Reactor) {
        
    }
}
