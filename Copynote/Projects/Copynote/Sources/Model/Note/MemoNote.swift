//
//  MemoPost.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/31.
//  Copyright © 2022 Copynote. All rights reserved.
//

import Foundation
import RealmSwift

struct MemoNote {
    var id: String
    let note: Note?
    
    func toRealm() -> MemoNoteRealm {
        return MemoNoteRealm(id: id, note: note?.toRealm())
    }
}

class MemoNoteRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var note: NoteRealm?
    
    convenience init(id: String, note: NoteRealm?) {
        self.init()
        
        self.id = id
        self.note = note
    }
    
    func toDomain() -> MemoNote {
        return .init(id: id, note: note?.toDomain())
    }
}
