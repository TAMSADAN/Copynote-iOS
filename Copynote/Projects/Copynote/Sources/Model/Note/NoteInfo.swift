//
//  PostInfo.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/31.
//  Copyright © 2022 Copynote. All rights reserved.
//

import Foundation
import RealmSwift

struct Note {
    var id: String
    var kind: Kind
    var location: Location?
    var title: String
    var content: String
    
    func toRealm() -> NoteRealm {
        return .init(id: id, kind: kind, location: location?.toRealm(), title: title, content: content)
    }
}

class NoteRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var kind: Kind
    @Persisted var location: LocationRealm?
    @Persisted var title: String
    @Persisted var content: String
    
    convenience init(id: String, kind: Kind, location: LocationRealm?, title: String, content: String) {
        self.init()
        
        self.id = id
        self.kind = kind
        self.location = location
        self.title = title
        self.content = content
    }
    
    func toDomain() -> Note {
        return .init(id: id, kind: kind, location: location?.toDomain(), title: title, content: content)
    }
}
