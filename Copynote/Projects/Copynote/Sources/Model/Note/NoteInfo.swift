//
//  PostInfo.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/31.
//  Copyright © 2022 Copynote. All rights reserved.
//

import Foundation
import RealmSwift

struct NoteInfo {
    var id: String
    var kind: Kind
    var location: String
    var title: String
    
    func toRealm() -> NoteInfoRealm {
        return .init(id: id, kind: kind, location: location, title: title)
    }
}

class NoteInfoRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var kind: Kind
    @Persisted var location: String
    @Persisted var title: String
    
    convenience init(id: String, kind: Kind, location: String, title: String) {
        self.init()
        
        self.id = id
        self.kind = kind
        self.location = location
        self.title = title
    }
    
    func toDomain() -> NoteInfo {
        return .init(id: id, kind: kind, location: location, title: title)
    }
}
