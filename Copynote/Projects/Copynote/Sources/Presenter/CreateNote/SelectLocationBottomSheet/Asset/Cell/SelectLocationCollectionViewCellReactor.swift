//
//  SelectLocationCollectionViewCellReactor.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/24.
//  Copyright © 2023 Copynote. All rights reserved.
//

import ReactorKit

class SelectLocationCollectionViewCellReactor: Reactor {
    enum Action {}
    
    enum Mutation {}
    
    struct State {
        let location: Location
        let isSelected: Bool
    }
    
    var initialState: State
    
    init(location: Location, isSelected: Bool = false) {
        self.initialState = .init(location: location, isSelected: isSelected)
    }
}
