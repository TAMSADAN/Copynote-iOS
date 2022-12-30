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
    
    func bind(reactor: Reactor) {
        
    }
}
