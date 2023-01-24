//
//  PostCollectionViewHeaderReactor.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import ReactorKit

class PostCollectionViewHeaderReactor: Reactor {
    enum Action {}
    enum Mutation {}
    struct State {
        let selectedKind: Kind
        let kinds: [Kind] = Kind.allCases
        
    }
    
    var initialState: State
    private let noteService: NoteServiceType
    
    init(selectedKind: Kind, noteService: NoteServiceType) {
        self.noteService = noteService
        self.initialState = .init(selectedKind: selectedKind)
    }
}
