//
//  CreateNoteReactor.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import ReactorKit

class CreateNoteReactor: Reactor {
    enum Action {}
    enum Mutation {}
    struct State {
        var info: NoteInfo
    }

    var initialState: State
    
    init(info: NoteInfo) {
        self.initialState = .init(info: info)
    }
}
