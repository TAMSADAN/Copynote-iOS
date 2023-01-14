//
//  CreateNoteReactor.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import ReactorKit

class CreateNoteReactor: Reactor {
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setDismiss(Bool)
    }
    
    struct State {
        var note: Note
        var kind: Kind
        var dismiss: Bool = false
    }

    var initialState: State
    private let noteService: NoteServiceType
    
    init(note: Note, noteService: NoteServiceType) {
        self.noteService = noteService
        self.initialState = .init(note: note, kind: note.kind)
    }
}

extension CreateNoteReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .empty()
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let eventMutation = noteService.event.flatMap { event -> Observable<Mutation> in
            switch event {
            case .createOrUpdateNote:
                return .concat([
                    .just(.setDismiss(true)),
                    .just(.setDismiss(false))
                ])
                
            default:
                return .empty()
            }
        }
        
        return Observable.merge(eventMutation, mutation)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setDismiss(bool):
            newState.dismiss = bool
        }
        
        return newState
    }
}
