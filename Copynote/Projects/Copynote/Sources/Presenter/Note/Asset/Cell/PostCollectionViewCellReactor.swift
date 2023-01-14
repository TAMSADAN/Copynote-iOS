//
//  NoteCollectionViewCellReactor.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import ReactorKit

class PostCollectionViewCellReactor: Reactor {
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
