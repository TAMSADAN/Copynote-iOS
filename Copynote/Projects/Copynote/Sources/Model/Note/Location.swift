//
//  Location.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/01.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import RealmSwift

struct Location {
    let id: String
    let name: String
    var counts: Int = 0
    
    func toRealm() -> LocationRealm {
        return .init(id: id, name: name)
    }
}

class LocationRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    
    convenience init(id: String, name: String) {
        self.init()
        
        self.id = id
        self.name = name
    }
    
    func toDomain() -> Location {
        return .init(id: id, name: name)
    }
}
