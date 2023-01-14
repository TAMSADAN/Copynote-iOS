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
    private let presentCreateMemoNoteView: () -> CreateMemoNoteView
    private let presentCreateUrlNoteView: () -> CreateUrlNoteView

    // MARK: - UI Components
    
    let kindButton: UIButton = .init(type: .system)
    let categoryButton: UIButton = .init(type: .system)
    let divider: UIView = .init()
    let scrollView: UIScrollView = .init()
    
    var createNoteView: UIView = .init()
    
    init(reactor: Reactor,
         mode: PresentMode,
         presentCreateMemoNoteView: @escaping () -> CreateMemoNoteView,
         presentCreateUrlNoteView: @escaping () -> CreateUrlNoteView
    ) {
        self.mode = mode
        self.presentCreateMemoNoteView = presentCreateMemoNoteView
        self.presentCreateUrlNoteView = presentCreateUrlNoteView
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        willPresentCreateMemoNoteView()
    }
    
    // MARK: - Setup Methods
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        showNavigtaionBar(isHidden: false)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        kindButton.setTitle("     memo     ", for: .normal)
        kindButton.setTitleColor(.white, for: .normal)
        kindButton.tintColor = .black
        kindButton.titleLabel?.font = CopynoteFontFamily.HappinessSansPrint.bold.font(size: 16)
        kindButton.cornerRound(radius: 15)
        kindButton.backgroundColor = .black
        
        categoryButton.setTitle("     테스트     ", for: .normal)
        categoryButton.setTitleColor(.white, for: .normal)
        categoryButton.tintColor = .black
        categoryButton.titleLabel?.font = CopynoteFontFamily.HappinessSansPrint.bold.font(size: 13)
        categoryButton.cornerRound(radius: 15)
        categoryButton.backgroundColor = .black
        
        divider.backgroundColor = .black
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([kindButton,
                                 categoryButton,
                                 divider,
                                 scrollView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        kindButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(35)
        }
        
        categoryButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(kindButton.snp.trailing).offset(10)
            $0.height.equalTo(35)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(categoryButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        
    }
}

extension CreateNoteViewController {
    func willPresentCreateMemoNoteView() {
        createNoteView = presentCreateMemoNoteView()
        willPresentCreateNoteView(view: createNoteView)
    }
    
    func willPresentCreateUrlNoteView() {
        createNoteView = presentCreateUrlNoteView()
        willPresentCreateNoteView(view: createNoteView)
    }
    
    func willPresentCreateNoteView(view: UIView) {
        view.removeFromSuperview()
        
        scrollView.addSubview(view)
        
        view.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}
