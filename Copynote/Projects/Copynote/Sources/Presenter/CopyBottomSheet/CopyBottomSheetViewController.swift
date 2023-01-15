//
//  CopyBottomSheetViewController.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import UIKit
import ReactorKit

class CopyBottomSheetViewController: BottomSheetViewController, View {
    // MARK: - UI Components
    
    typealias Reactor = CopyBottomSheetReactor
    
    // MARK: - UI Components
    
    let contentView: UIView = .init()
    let titleLabel: UILabel = .init()
    let copyView: UIView = .init()
    let copyLabel: UILabel = .init()
    
    // MARK: - Initializer
    
    init(mode: BottomSheetViewController.Mode, reactor: Reactor) {
        super.init(mode: mode)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addContentView(view: contentView)
    }
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.text = "copied !"
        titleLabel.font = CopynoteFontFamily.HappinessSansPrint.title.font(size: 18)
        titleLabel.textColor = .black
        
        copyView.backgroundColor = .systemGray6
        copyView.cornerRound(radius: 5)
        
        copyLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 14)
        copyLabel.numberOfLines = 0
        copyLabel.textColor = .black
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([titleLabel, copyView])
        copyView.addSubviews([copyLabel])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        copyView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(100)
        }
        
        copyLabel.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    func bind(reactor: Reactor) {
        reactor.state
            .map(\.note)
            .bind { [weak self] note in
                self?.copyLabel.text = note.content
            }
            .disposed(by: disposeBag)
    }
}
