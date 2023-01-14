//
//  CreateUrlNoteReactor.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/31.
//  Copyright © 2022 Copynote. All rights reserved.
//

import ReactorKit

class CreateUrlNoteReactor: Reactor {
    enum Action {
        case tapDoneButton
    }
    
    enum Mutation {}
    
    struct State {
        var info: NoteInfo
    }
    
    var initialState: State
    private let urlNoteService: UrlNoteServiceType
    
    init(info: NoteInfo, urlNoteService: UrlNoteServiceType) {
        self.urlNoteService = urlNoteService
        self.initialState = .init(info: info)
    }
}
