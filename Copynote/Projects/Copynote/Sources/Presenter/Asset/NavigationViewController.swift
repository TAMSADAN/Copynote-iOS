//
//  NavigationViewController.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit

import UIKit

class NavigationBar: UIView {
    var backButton = UIButton()
    var title = UILabel()
    var subTitle = UILabel()
}

protocol NavigationViewControllerProtocol: AnyObject {
    var statusBar: UIView { get }
    var navigationBar: NavigationBar { get }
    var contentView: UIView { get }
    
    func setupNavigationBar()
    func showNavigtaionBar(isHidden: Bool)
}

class NavigationViewController: BaseViewController, NavigationViewControllerProtocol {
    
    // MARK: - UI Components
    
    var statusBar = UIView()
    var navigationBar = NavigationBar()
    var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()

        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        navigationBar.backButton.setImage(.init(systemName: "chevron.left"), for: .normal)
        navigationBar.backButton.tintColor = .black
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([statusBar, navigationBar, contentView])
      
        navigationBar.addSubviews([navigationBar.title, navigationBar.backButton, navigationBar.subTitle])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        statusBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        navigationBar.backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        navigationBar.title.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        navigationBar.subTitle.snp.makeConstraints {
            $0.leading.equalTo(navigationBar.title.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        navigationBar.backButton.rx.tap
            .bind { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func setupNavigationBar() {
        showNavigtaionBar(isHidden: true)
    }
    
    func showNavigtaionBar(isHidden: Bool = false) {
        navigationBar.isHidden = isHidden
        
        if isHidden {
            contentView.snp.remakeConstraints {
                $0.top.equalTo(statusBar.snp.bottom)
                $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                $0.bottom.equalToSuperview()
            }
        } else {
            contentView.snp.remakeConstraints {
                $0.top.equalTo(navigationBar.snp.bottom)
                $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                $0.bottom.equalToSuperview()
            }
        }
    }
}
