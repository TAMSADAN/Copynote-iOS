//
//  CategoryCollectionViewCellReactor.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import ReactorKit

class LocationCollectionViewCellReactor: Reactor {
    enum Action {}
    
    enum Mutation {}
    
    struct State {
        let location: Location
    }
    
    var initialState: State

    init(location: Location) {
        self.initialState = .init(location: location)
    }
}

