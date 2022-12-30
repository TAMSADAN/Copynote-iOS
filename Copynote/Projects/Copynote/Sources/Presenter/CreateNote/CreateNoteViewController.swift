//
//  CreateNoteViewController.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit
import ReactorKit

class CreateNoteViewController: NavigationViewController, View {
    // MARK: - Properties
    
    typealias Reactor = CreateNoteReactor

    let mode: PresentMode

    // MARK: - UI Components
    
    let kindButton: UIButton = .init(type: .system)
    let categoryButton: UIButton = .init(type: .system)
    let divider: UIView = .init()
    let titleTextField: UITextField = .init()
    let contentTextView: UITextView = .init()
    
    init(mode: PresentMode, reactor: Reactor) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        showNavigtaionBar(isHidden: false)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        kindButton.setTitle("태그: Memo", for: .normal)
        kindButton.setTitleColor(.black, for: .normal)
        kindButton.tintColor = .black
        kindButton.titleLabel?.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 16)
        
        categoryButton.setTitle("카테고리: 테스트", for: .normal)
        categoryButton.setTitleColor(.black, for: .normal)
        categoryButton.tintColor = .black
        categoryButton.titleLabel?.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 16)
        
        divider.backgroundColor = .black
        
        titleTextField.placeholder = "제목을 입력하세요."
        titleTextField.font = CopynoteFontFamily.HappinessSansPrint.title.font(size: 30)
        
        contentTextView.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 17)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([kindButton, categoryButton, divider, titleTextField, contentTextView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        kindButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        categoryButton.snp.makeConstraints {
            $0.top.equalTo(kindButton.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(categoryButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        
    }
}
