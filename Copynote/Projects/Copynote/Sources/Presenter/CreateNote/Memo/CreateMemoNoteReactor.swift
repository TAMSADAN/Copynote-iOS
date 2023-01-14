//
//  CreateMemoNoteReactor.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/31.
//  Copyright © 2022 Copynote. All rights reserved.
//

import ReactorKit

class CreateMemoNoteReactor: Reactor {
    enum Action {
        case tapDoneButton
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var info: NoteInfo
    }
    
    var initialState: State
    private let memoNoteService: MemoNoteServiceType
    
    init(info: NoteInfo, memoNoteService: MemoNoteServiceType) {
        self.memoNoteService = memoNoteService
        self.initialState = .init(info: info)
    }
}
