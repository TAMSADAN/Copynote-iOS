//
//  SelectKindCollectionViewCellReactor.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import ReactorKit

class SelectKindCollectionViewCellReactor: Reactor {
    enum Action {}
    
    enum Mutation {}
    
    struct State {
        let kind: Kind
        let isSelected: Bool
    }
    
    var initialState: State
    
    init(kind: Kind, isSelected: Bool = false) {
        self.initialState = .init(kind: kind, isSelected: isSelected)
    }
}
