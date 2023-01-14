//
//  Url.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/31.
//  Copyright © 2022 Copynote. All rights reserved.
//

import Foundation
import RealmSwift

struct UrlNote {
    var id: String
    let note: Note?
    
    func toRealm() -> UrlNoteRealm {
        return .init(id: id, note: note?.toRealm())
    }
}

class UrlNoteRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var note: NoteRealm?
    @Persisted var url: String
    
    convenience init(id: String, note: NoteRealm?) {
        self.init()
        
        self.id = id
        self.note = note
        self.url = url
    }
    
    func toDomain() -> UrlNote {
        return .init(id: id, note: note?.toDomain())
    }
}
