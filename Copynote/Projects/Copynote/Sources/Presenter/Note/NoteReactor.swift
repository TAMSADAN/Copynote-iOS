//
//  NoteReactor.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit
import ReactorKit

class NoteReactor: Reactor {
    enum Action {
        case refresh
        case tapKind(Kind)
        case tapLocationItem(IndexPath, LocationItem)
        case tapNoteItem(IndexPath, NoteItem)
    }

    enum Mutation {
        case setNotes([Note])
        case setSelectedKind(Kind)
        case setSelectedLocation(Location)
        case setLocationSections([LocationSectionModel])
        case setNoteSections([NoteSectionModel])
    }

    struct State {
        var notes: [Note] = []
        var selectedKind: Kind = .all
        var selectedLocation: Location?
        var locationSections: [LocationSectionModel] = []
        var noteSections: [NoteSectionModel] = []
    }

    var initialState: State
    let locationService: LocationServiceType
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
            
        case let .tapKind(kind):
            return .concat([
                .just(.setSelectedKind(kind)),
                .just(.setNoteSections(makeSections(notes: currentState.notes, selectedKind: kind, selectedLocation: currentState.selectedLocation)))
            ])
            
        case let .tapLocationItem(_, item):
            switch item {
            case let .location(reactor):
                let location = reactor.initialState.location
                
                return .concat([
                    .just(.setSelectedLocation(location)),
                    .just(.setNoteSections(makeSections(notes: currentState.notes, selectedKind: currentState.selectedKind, selectedLocation: location)))
                ])
            }
            
        case .tapNoteItem:
            return .empty()
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let locationEventMutation = locationService.event.withUnretained(self).flatMap { this, event -> Observable<Mutation> in
            switch event {
            case let .fetchLocations(locations):
                if this.currentState.selectedLocation == nil, let location = locations.first {
                    return .concat([
                        .just(.setLocationSections(this.makeSections(locations: locations))),
                        .just(.setSelectedLocation(location))
                    ])
                }
                return .just(.setLocationSections(this.makeSections(locations: locations)))
                
            default:
                return .empty()
            }
        }
        
        let noteEventMutation = noteService.event.withUnretained(self).flatMap { this, event -> Observable<Mutation> in
            switch event {
            case let .fetchNotes(notes):
                return .concat([
                    .just(.setNotes(notes)),
                    .just(.setNoteSections(this.makeSections(notes: notes, selectedKind: this.currentState.selectedKind, selectedLocation: this.currentState.selectedLocation)))
                ])

            default:
                return .empty()
            }
        }
        
        return Observable.merge(locationEventMutation, noteEventMutation, mutation)
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setNotes(notes):
            newState.notes = notes
            
        case let .setSelectedKind(kind):
            newState.selectedKind = kind
            
        case let .setSelectedLocation(location):
            newState.selectedLocation = location
            
        case let .setLocationSections(sections):
            newState.locationSections = sections
            
        case let .setNoteSections(sections):
            newState.noteSections = sections
        }

        return newState
    }
    
    private func makeSections(locations: [Location]) -> [LocationSectionModel] {
        let items: [LocationItem] = locations.map({ location -> LocationItem in
            return .location(.init(location: location))
        })
        
        let section: LocationSectionModel = .init(model: .location(items), items: items)
        
        if items.isEmpty {
            return []
        } else {
            return [section]
        }
    }
    
    private func makeSections(notes: [Note], selectedKind: Kind, selectedLocation: Location?) -> [NoteSectionModel] {
        let items: [NoteItem] = {
            var noteItems: [NoteItem] = []
            
            notes.forEach({ note in
                if (selectedKind == .all || note.kind == selectedKind) && note.location?.id == selectedLocation?.id {
                    noteItems.append(.post(.init(note: note)))
                }
            })
            
            if noteItems.isEmpty {
                noteItems =  [.empty]
            }
            
            return noteItems
        }()
        
        let section: NoteSectionModel = .init(model: .post(items), items: items)
        
        return [section]
    }
}
