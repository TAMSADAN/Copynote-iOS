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
        case title(String)
        case content(String)
    }
    
    enum Mutation {
        case setMemoNote(MemoNote)
        case setTitle(String)
        case setContent(String)
    }
    
    struct State {
        var note: Note
        var memoNote: MemoNote
    }
    
    var initialState: State
    private let memoNoteService: MemoNoteServiceType
    
    init(note: Note, memoNoteService: MemoNoteServiceType) {
        self.memoNoteService = memoNoteService
        self.initialState = .init(note: note, memoNote: .init(id: note.id, note: note))
        
        memoNoteService.fetchNote(id: note.id)
    }
}

extension CreateMemoNoteReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapDoneButton:
            memoNoteService.createOrUpdateNote(note: currentState.memoNote)
            return .empty()
            
        case let .title(text):
            return .just(.setTitle(text))
            
        case let .content(text):
            return .just(.setContent(text))
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let eventMutation = memoNoteService.event.flatMap { event -> Observable<Mutation> in
            switch event {
            case let .fetchNote(note):
                return .just(.setMemoNote(note))
                
            default:
                return .empty()
            }
        }
        
        return Observable.merge(eventMutation, mutation)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setMemoNote(note):
            newState.memoNote = note
            
        case let .setTitle(text):
            newState.memoNote.note?.title = text
            
        case let .setContent(text):
            newState.memoNote.note?.content = text
        }
        
        return newState
    }
}
