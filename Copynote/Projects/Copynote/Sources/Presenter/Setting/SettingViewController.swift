//
//  SettingViewController.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import UIKit
import ReactorKit

class SettingViewController: NavigationViewController, View {
    // MARK: - Properties
    
    typealias Reactor = SettingReactor
    
    // MARK: - UI Components
    
    let guideView: UIView = .init()
    let guideLabel: UILabel = .init()
    
    let stackView: UIStackView = .init()
    
    let usefuleView: SettingView = .init(image: .init(systemName: "sun.max"), title: "붙여넣기 허용하기")
    let githubView: SettingView = .init(image: .init(systemName: "chevron.left.forwardslash.chevron.right"), title: "깃허브 별 달러가기")
    let starView: SettingView = .init(image: .init(systemName: "star"), title: "앱스토어 별점 주러가기")
    let divider: UIView = .init()
    
    // MARK: - Initializer
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        showNavigtaionBar(isHidden: false)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .vertical
        
        guideView.backgroundColor = .systemGray6
        guideView.cornerRound(radius: 10)
        
        guideLabel.text = "현재 데모 버전입니다."
        guideLabel.numberOfLines = 0
        guideLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 15)
        guideLabel.textColor = .black
        
        divider.backgroundColor = .black
        
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubviews([usefuleView, divider, githubView, starView])
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([guideView, stackView])
        
        guideView.addSubviews([guideLabel])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        guideView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        guideLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(guideView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        usefuleView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        githubView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        starView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        divider.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - Bind Method
    
    func bind(reactor: Reactor) {
        
    }
}
