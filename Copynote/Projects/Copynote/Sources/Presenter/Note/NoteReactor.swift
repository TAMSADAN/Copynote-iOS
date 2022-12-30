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
        case setCategorySections([LocationSectionModel])
        case setNoteSections([NoteSectionModel])
    }

    struct State {
        var categorySections: [LocationSectionModel] = []
        var noteSections: [NoteSectionModel] = []
    }

    var initialState: State

    init() {
        self.initialState = .init()
    }
}

extension NoteReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .concat([
                .just(.setCategorySections(makeSections())),
                .just(.setNoteSections(makeSections()))
            ])
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setCategorySections(sections):
            newState.categorySections = sections
            
        case let .setNoteSections(sections):
            newState.noteSections = sections
        }

        return newState
    }
    
    private func makeSections() -> [LocationSectionModel] {
        let items: [LocationItem] = [.location(.init(location: .init(id: "1", name: "전체"))), .location(.init(location: .init(id: "2", name: "우리집")))]
        let section: LocationSectionModel = .init(model: .location(items), items: items)

        return [section]
    }
    
    private func makeSections() -> [NoteSectionModel] {
        let items: [NoteItem] = [.post(.init()), .post(.init()), .post(.init())]
        let section: NoteSectionModel = .init(model: .post(items), items: items)
        
        return [section]
    }
}
