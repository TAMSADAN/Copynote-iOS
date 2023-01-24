//
//  CreateNoteReactor.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import ReactorKit

class CreateOrUpdateNoteReactor: Reactor {
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setKind(Kind)
        case setDismiss(Bool)
    }
    
    struct State {
        var note: Note
        var selectedKind: Kind
        var selectedLocation: Location?
        var dismiss: Bool = false
    }

    var initialState: State
    private let noteService: NoteServiceType
    private let selectKindService: SelectKindServiceType
    
    init(note: Note,
         noteService: NoteServiceType,
         selectKindService: SelectKindServiceType) {
        self.noteService = noteService
        self.selectKindService = selectKindService
        self.initialState = .init(note: note,
                                  selectedKind: note.kind,
                                  selectedLocation: note.location)
    }
}

extension CreateOrUpdateNoteReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .empty()
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let noteEventMutation = noteService.event.flatMap { event -> Observable<Mutation> in
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
        
        let selectKindEventMutation = selectKindService.event.flatMap { event -> Observable<Mutation> in
            switch event {
            case let .selectKind(kind):
                return .just(.setKind(kind))
            }
        }
        
        return Observable.merge(noteEventMutation, selectKindEventMutation, mutation)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setDismiss(bool):
            newState.dismiss = bool
            
        case let .setKind(kind):
            newState.selectedKind = kind
        }
        
        return newState
    }
}
