//
//  CreateNoteViewController.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit
import ReactorKit

class CreateOrUpdateNoteViewController: NavigationViewController, View {
    // MARK: - Properties
    
    typealias Reactor = CreateOrUpdateNoteReactor
    
    private let pushSelectKindBottomSheetScreen: (_ kind: Kind) -> SelectKindBottomSheetViewController
    private let presentCreateOrUpdateMemoNoteView: (_ note: Note) -> CreateOrUpdateMemoNoteView
    private let presentCreateOrUpdateUrlNoteView: (_ note: Note) -> CreateOrUpdateUrlNoteView

    // MARK: - UI Components
    
    private let kindButton: UIButton = .init(type: .system)
    private let categoryButton: UIButton = .init(type: .system)
    private let divider: UIView = .init()
    private let containerView: UIView = .init()
    
    private var createOrUpdateNoteView: UIView = .init()
    
    // MARK: - Initializer
    
    init(reactor: Reactor,
         pushSelectKindBottomSheetScreen: @escaping (_ kind: Kind) -> SelectKindBottomSheetViewController,
         presentCreateMemoNoteView: @escaping (_ note: Note) -> CreateOrUpdateMemoNoteView,
         presentCreateUrlNoteView: @escaping (_ note: Note) -> CreateOrUpdateUrlNoteView
    ) {
        self.pushSelectKindBottomSheetScreen = pushSelectKindBottomSheetScreen
        self.presentCreateOrUpdateMemoNoteView = presentCreateMemoNoteView
        self.presentCreateOrUpdateUrlNoteView = presentCreateUrlNoteView
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
    }
    
    // MARK: - Setup Methods
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        showNavigtaionBar(isHidden: false)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        kindButton.setTitle("memo", for: .normal)
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
                                 containerView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        kindButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(70)
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
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .map { _ in .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        kindButton.rx.tap
            .bind { [weak self] in
                self?.willPushSelectKindBottomSheetViewController(kind: reactor.currentState.kind)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.kind)
            .bind { [weak self] kind in
                self?.kindButton.setTitle(kind.title, for: .normal)
                
                switch kind {
                case .all, .memo:
                    self?.willPresentCreateOrUpdateMemoNoteView(note: reactor.currentState.note)
                case .url:
                    self?.willPresentCreateOrUpdateUrlNoteView(note: reactor.currentState.note)
                }
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.dismiss)
            .filter { $0 }
            .bind { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}

extension CreateOrUpdateNoteViewController {
    private func willPushSelectKindBottomSheetViewController(kind: Kind) {
        let viewController = pushSelectKindBottomSheetScreen(kind)
        
        self.present(viewController, animated: true)
    }
    
    private func willPresentCreateOrUpdateMemoNoteView(note: Note) {
        guard (createOrUpdateNoteView as? CreateOrUpdateMemoNoteView) == nil else { return }
        
        createOrUpdateNoteView = presentCreateOrUpdateMemoNoteView(note)
        willPresentCreateOrUpdateNoteView(view: createOrUpdateNoteView)
    }
    
    private func willPresentCreateOrUpdateUrlNoteView(note: Note) {
        guard (createOrUpdateNoteView as? CreateOrUpdateUrlNoteView) == nil else { return }
        
        createOrUpdateNoteView = presentCreateOrUpdateUrlNoteView(note)
        willPresentCreateOrUpdateNoteView(view: createOrUpdateNoteView)
    }
    
    private func willPresentCreateOrUpdateNoteView(view: UIView) {
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        
        containerView.addSubview(view)
        
        view.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}
