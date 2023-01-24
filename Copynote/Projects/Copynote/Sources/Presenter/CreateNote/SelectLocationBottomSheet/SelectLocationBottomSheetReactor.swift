//
//  SelectLocationBottomSheetReactor.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/24.
//  Copyright © 2023 Copynote. All rights reserved.
//

import UIKit
import ReactorKit

class SelectLocationBottomSheetReactor: Reactor {
    enum Action {
        case refresh
        case tapKindItem(IndexPath, SelectKindItem)
    }
    
    enum Mutation {
        case setKind(Kind)
        case setSections([SelectKindSectionModel])
        case setDismiss(Bool)
    }
    
    struct State {
        let kinds: [Kind] = Array(Kind.allCases.suffix(from: 1))
        var selectedKind: Kind
        var sections: [SelectKindSectionModel] = []
        var dismiss: Bool = false
    }
    
    var initialState: State
    let selectKindService: SelectKindServiceType
    
    init(selectedKind: Kind, selectKindService: SelectKindServiceType) {
        self.initialState = .init(selectedKind: selectedKind)
        self.selectKindService = selectKindService
    }
}

extension SelectLocationBottomSheetReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .just(.setSections(makeSections(kinds: initialState.kinds,
                                                   selectedKind: currentState.selectedKind)))
        case let .tapKindItem(_, item):
            switch item {
            case let .kind(reactor):
                let selectedKind = reactor.initialState.kind
                selectKindService.selectKind(kind: selectedKind)
                return .concat([
                    .just(.setKind(selectedKind)),
                    .just(.setSections(makeSections(kinds: initialState.kinds,
                                                    selectedKind: selectedKind))),
                    .just(.setDismiss(true)),
                    .just(.setDismiss(false))
                ])
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setKind(kind):
            newState.selectedKind = kind
            
        case let .setSections(sections):
            newState.sections = sections
            
        case let .setDismiss(bool):
            newState.dismiss = bool
        }
        
        return newState
    }
}

extension SelectLocationBottomSheetReactor {
    private func makeSections(kinds: [Kind], selectedKind: Kind) -> [SelectKindSectionModel] {
        let items: [SelectKindItem] = kinds.map({ (kind) in
            if selectedKind == kind {
                return .kind(.init(kind: kind, isSelected: true))
            } else {
                return .kind(.init(kind: kind, isSelected: false))
            }
        })
        let section: SelectKindSectionModel = .init(model: .kind(items), items: items)
        return [section]
    }
}
