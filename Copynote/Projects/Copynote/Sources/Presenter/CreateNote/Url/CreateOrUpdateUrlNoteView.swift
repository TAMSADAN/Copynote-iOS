//
//  CreateUrlNoteView.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/31.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit
import ReactorKit

class CreateOrUpdateUrlNoteView: BaseView, View {
    // MARK: - Properties
    
    typealias Reactor = CreateOrUpdateUrlNoteReactor
    
    // MARK: - Initializer
    
    init(reactor: Reactor) {
        super.init(frame: .zero)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind Method
    
    func bind(reactor: Reactor) {
        
    }
}
