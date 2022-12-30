//
//  TypeCollectionViewCellReactor.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import ReactorKit

class KindCollectionViewCellReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let kind: Kind
    }
    
    var initialState: State
    init(kind: Kind) {
        self.initialState = .init(kind: kind)
    }
}
