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
    let info: NoteInfo?
    let content: String
    
    func toRealm() -> MemoNoteRealm {
        return MemoNoteRealm(id: id, info: info?.toRealm(), content: content)
    }
    
    func toNote() -> Note {
        return Note(info: info, content: content)
    }
}

class MemoNoteRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var info: NoteInfoRealm?
    @Persisted var content: String
    
    convenience init(id: String, info: NoteInfoRealm?, content: String) {
        self.init()
        
        self.id = id
        self.info = info
        self.content = content
    }
    
    func toDomain() -> MemoNote {
        return .init(id: id, info: info?.toDomain(), content: content)
    }
}
