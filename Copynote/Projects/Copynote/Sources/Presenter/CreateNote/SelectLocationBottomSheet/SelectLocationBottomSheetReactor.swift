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
        case tapLocationItem(IndexPath, SelectLocationItem)
    }
    
    enum Mutation {
        case setLocations([Location])
        case setSelectedLocation(Location)
        case setSections([SelectLocationSectionModel])
        case setDismiss(Bool)
    }
    
    struct State {
        var locations: [Location] = []
        var selectedLocation: Location
        var sections: [SelectLocationSectionModel] = []
        var dismiss: Bool = false
    }
    
    var initialState: State
    let locationService: LocationServiceType
    let selectLocationService: SelectLocationServiceType
    
    init(selectedLocation: Location,
         locationService: LocationServiceType,
         selectLocationService: SelectLocationServiceType) {
        self.initialState = .init(selectedLocation: selectedLocation)
        self.locationService = locationService
        self.selectLocationService = selectLocationService
    }
}

extension SelectLocationBottomSheetReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            locationService.fetchLocations()
            return .empty()
        case let .tapLocationItem(_, item):
            switch item {
            case let .location(reactor):
                let selectedLocation = reactor.initialState.location
                selectLocationService.selectLocation(location: selectedLocation)
                return .concat([
                    .just(.setSelectedLocation(selectedLocation)),
                    .just(.setSections(makeSections(locations: currentState.locations, selectedLocation: selectedLocation))),
                    .just(.setDismiss(true)),
                    .just(.setDismiss(false))
                ])
            }
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let locationEventMutation = locationService.event.withUnretained(self).flatMap({ this, event -> Observable<Mutation> in
            switch event {
            case let .fetchLocations(locations):
                return .concat([
                    .just(.setLocations(locations)),
                    .just(.setSections(this.makeSections(locations: locations, selectedLocation: this.currentState.selectedLocation)))
                ])
                
            default:
                return .empty()
            }
        })
        
        return Observable.merge(locationEventMutation, mutation)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLocations(locations):
            newState.locations = locations
            
        case let .setSelectedLocation(location):
            newState.selectedLocation = location
            
        case let .setSections(sections):
            newState.sections = sections
            
        case let .setDismiss(bool):
            newState.dismiss = bool
        }
        
        return newState
    }
}

extension SelectLocationBottomSheetReactor {
    private func makeSections(locations: [Location], selectedLocation: Location) -> [SelectLocationSectionModel] {
        let items: [SelectLocationItem] = locations.map({ location in
            return .location(.init(location: location, isSelected: location.id == selectedLocation.id))
        })
        
        let section: SelectLocationSectionModel = .init(model: .location(items), items: items)
        return [section]
    }
}
