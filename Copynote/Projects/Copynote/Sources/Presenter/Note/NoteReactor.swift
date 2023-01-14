//
//  NoteReactor.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import ReactorKit

class NoteReactor: Reactor {
    enum Action {
        case refresh
    }

    enum Mutation {
        case setLocationSections([LocationSectionModel])
        case setNoteSections([NoteSectionModel])
    }

    struct State {
        var locationSections: [LocationSectionModel] = []
        var noteSections: [NoteSectionModel] = []
        var loaction: String?
    }

    var initialState: State
    private let locationService: LocationServiceType
    let noteService: NoteServiceType
    
    init(locationService: LocationServiceType,
         noteService: NoteServiceType) {
        self.locationService = locationService
        self.noteService = noteService
        self.initialState = .init()
    }
}

extension NoteReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            locationService.fetchLocations()
            noteService.fetchNotes()
            return .empty()
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let locationEventMutation = locationService.event.withUnretained(self).flatMap { this, event -> Observable<Mutation> in
            switch event {
            case let .fetchLocations(locations):
                return .just(.setLocationSections(this.makeSections(locations: locations)))
                
            default:
                return .empty()
            }
        }
        
        let noteEventMutation = noteService.event.withUnretained(self).flatMap { this, event -> Observable<Mutation> in
            switch event {
            case let .fetchNotes(notes):
                return .just(.setNoteSections(this.makeSections(notes: notes)))
                
            default:
                return .empty()
            }
        }
        
        return Observable.merge(locationEventMutation, noteEventMutation, mutation)
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLocationSections(sections):
            newState.locationSections = sections
            
        case let .setNoteSections(sections):
            newState.noteSections = sections
        }

        return newState
    }
    
    private func makeSections(locations: [Location]) -> [LocationSectionModel] {
        let items: [LocationItem] = locations.map({ location -> LocationItem in
            return .location(.init(location: location.name))
        })
        
        let section: LocationSectionModel = .init(model: .location(items), items: items)
        
        if items.isEmpty {
            return []
        } else {
            return [section]
        }
    }
    
    private func makeSections(notes: [Note]) -> [NoteSectionModel] {
        let items: [NoteItem] = notes.map({ note -> NoteItem in
            return .post(.init(note: note))
        })
        
        let section: NoteSectionModel = .init(model: .post(items), items: items)
        
        if items.isEmpty {
            return []
        } else {
            return [section]
        }
    }
}
