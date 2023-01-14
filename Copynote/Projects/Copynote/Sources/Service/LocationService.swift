//
//  LocationService.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/01.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

enum LocationEvent {
    case fetchLocations([Location])
    case fetchLocation(Location)
    case createLocation(Location)
}

protocol LocationServiceType {
    var event: PublishSubject<LocationEvent> { get }
    
    func fetchLocations()
    func fetchLocation(id: String)
    func createLocation(location: Location)
}

class LocationService: LocationServiceType {
    var event = PublishSubject<LocationEvent>()
    let realm = Provider.shared.realm
    
    init() {
        if realm.objects(LocationRealm.self).count == 0 {
            
        }
    }
    
    func fetchLocations() {
        let objs = realm.objects(LocationRealm.self).map{ $0.toDomain() }
        
        event.onNext(.fetchLocations(Array(objs)))
    }
    
    func fetchLocation(id: String) {
        guard let obj = realm.objects(LocationRealm.self).where({ $0.id == id }).first else { return }
        
        event.onNext(.fetchLocation(obj.toDomain()))
    }
    
    func createLocation(location: Location) {
        try! realm.write {
            let obj = location.toRealm()
            obj.id = UUID().uuidString
            
            realm.add(obj)
            event.onNext(.createLocation(obj.toDomain()))
        }
    }
}
