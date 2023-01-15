//
//  KindBottomSheetReactor.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import ReactorKit

class SelectKindBottomSheetReactor: Reactor {
    enum Action {}
    
    enum Mutation {}
    
    struct State {
        var kind: Kind
    }
    
    var initialState: State
    
    init(kind: Kind) {
        self.initialState = .init(kind: kind)
    }
}
