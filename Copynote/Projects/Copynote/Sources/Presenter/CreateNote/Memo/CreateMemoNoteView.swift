//
//  CreateMemoNoteView.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/31.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit
import ReactorKit

class CreateMemoNoteView: BaseView, View {
    // MARK: - Properties
    
    typealias Reactor = CreateMemoNoteReactor
    
    // MARK: - UI Components
    
    let titleTextField: UITextField = .init()
    let contentTextView: UITextView = .init()
    
    override func setupProperty() {
        super.setupProperty()
        
        titleTextField.placeholder = "제목을 입력하세요."
        titleTextField.font = CopynoteFontFamily.HappinessSansPrint.title.font(size: 30)
        
        contentTextView.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 17)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([titleTextField, contentTextView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        
    }
}
