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
        case setCategorySections([CategorySectionModel])
        case setNoteSections([NoteSectionModel])
    }

    struct State {
        var categorySections: [CategorySectionModel] = []
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
            return .just(.setCategorySections(makeSections()))
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
    
    private func makeSections() -> [CategorySectionModel] {
        let items: [CategoryItem] = [.category(.init(category: .init(title: "전체"))), .category(.init(category: .init(title: "테스트")))]
        let section: CategorySectionModel = .init(model: .category(items), items: items)

        return [section]
    }
    
    private func makeSections() -> [NoteSectionModel] {
        let kindItems: [NoteItem] = [.kind(.init(kind: .init(title: "전체"))), .kind(.init(kind: .init(title: "메모"))), .kind(.init(kind: .init(title: "URL")))]
        let kindSection: NoteSectionModel = .init(model: .kind(kindItems), items: kindItems)
        
        let postItems: [NoteItem] = [.post(.init()), .post(.init()), .post(.init())]
        let postSection: NoteSectionModel = .init(model: .post(postItems), items: postItems)
        
        return [kindSection, postSection]
    }
}
