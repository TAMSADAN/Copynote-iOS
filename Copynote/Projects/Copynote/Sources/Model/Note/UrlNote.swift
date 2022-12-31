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
    let info: NoteInfo
    let url: String
    
    func toRealm() -> UrlNoteRealm {
        return .init(id: id, info: info.toRealm(), url: url)
    }
    
    func toNote() -> Note {
        return .init(info: info, content: url)
    }
}

class UrlNoteRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var info: NoteInfoRealm
    @Persisted var url: String
    
    convenience init(id: String, info: NoteInfoRealm, url: String) {
        self.init()
        
        self.id = id
        self.info = info
        self.url = url
    }
    
    func toDomain() -> UrlNote {
        return .init(id: id, info: info.toDomain(), url: url)
    }
}
