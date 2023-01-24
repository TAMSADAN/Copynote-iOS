//
//  CopyBottomSheetReactor.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import ReactorKit

class CopyBottomSheetReactor: Reactor {
    enum Action {}
    
    enum Mutation {}
    
    struct State {
        var note: Note
    }
    
    var initialState: State
    
    init(note: Note) {
        self.initialState = .init(note: note)
    }
}
