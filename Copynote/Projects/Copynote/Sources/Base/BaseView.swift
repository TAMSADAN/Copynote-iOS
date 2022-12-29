//
//  BaseView.swift
//  JYP-iOS
//
//  Created by 송영모 on 2022/07/17.
//  Copyright © 2022 JYP-iOS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol BaseViewProtocol {
    func setupProperty()
    func setupHierarchy()
    func setupLayout()
}

class BaseView: UIView, BaseViewProtocol {
    var disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    func setupProperty() { }
    
    func setupHierarchy() { }
    
    func setupLayout() { }
}
