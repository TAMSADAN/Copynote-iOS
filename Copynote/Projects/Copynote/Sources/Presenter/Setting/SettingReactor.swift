//
//  SettingReactor.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import ReactorKit

class SettingReactor: Reactor {
    enum Action {}
    
    enum Mutation {}
    
    struct State {}
    
    var initialState: State
    
    init() {
        self.initialState = .init()
    }
}
