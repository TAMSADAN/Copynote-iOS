//
//  CreateUrlNoteReactor.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/31.
//  Copyright © 2022 Copynote. All rights reserved.
//

import ReactorKit

class CreateOrUpdateUrlNoteReactor: Reactor {
    enum Action {
        case tapDoneButton
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var note: Note
    }
    
    var initialState: State
    private let urlNoteService: UrlNoteServiceType
    
    init(note: Note, urlNoteService: UrlNoteServiceType) {
        self.urlNoteService = urlNoteService
        self.initialState = .init(note: note)
    }
}
