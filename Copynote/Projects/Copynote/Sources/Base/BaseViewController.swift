//
//  BaseViewController.swift
//  JYP-iOS
//
//  Created by 송영모 on 2022/07/17.
//  Copyright © 2022 JYP-iOS. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

protocol BaseViewControllerProtocol: AnyObject {
    func setupProperty()
    func setupDelegate()
    func setupHierarchy()
    func setupLayout()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupProperty()
        setupDelegate()
        setupHierarchy()
        setupLayout()
    }

    func setupProperty() { }
    
    func setupDelegate() { }
    
    func setupHierarchy() { }
    
    func setupLayout() { }
}
