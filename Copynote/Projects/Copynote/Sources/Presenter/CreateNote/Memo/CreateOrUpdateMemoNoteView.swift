//
//  CreateMemoNoteView.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/31.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit
import ReactorKit

class CreateOrUpdateMemoNoteView: BaseView, View {
    // MARK: - Properties
    
    typealias Reactor = CreateOrUpdateMemoNoteReactor
    
    // MARK: - UI Components
    
    let titleTextField: UITextField = .init()
    let contentTextView: UITextView = .init()
    let accessoryView: UIView = .init(frame: CGRect(x: 0.0, y: 0.0, width: Provider.shared.screen.width, height: 45))
    let doneButton: UIButton = .init(type: .system)
    
    // MARK: - Initializer
    
    init(reactor: Reactor) {
        super.init(frame: .zero)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        accessoryView.backgroundColor = .black
        
        titleTextField.placeholder = "제목을 입력하세요."
        titleTextField.font = CopynoteFontFamily.HappinessSansPrint.title.font(size: 30)
        
        contentTextView.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 17)
        
        doneButton.setTitle("저장하기", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.titleLabel?.font = CopynoteFontFamily.HappinessSansPrint.title.font(size: 20)
        
        titleTextField.inputAccessoryView = accessoryView
        contentTextView.inputAccessoryView = accessoryView
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([titleTextField, contentTextView])
        accessoryView.addSubviews([doneButton])
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
        
        doneButton.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        titleTextField.rx.text
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .compactMap { $0 }
            .map { .title($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        contentTextView.rx.text
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .compactMap { $0 }
            .map { .content($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        doneButton.rx.tap
            .map { .tapDoneButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
