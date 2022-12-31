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
    let info: NoteInfo
    let content: String
}

//class MemoNoteRealm: Object {
////    @Persisted(primaryKey: true) var id: String
//    @Persisted var info: NoteInfoRealm
//    @Persisted var content: String
//    
//    convenience init(info: NoteInfoRealm, content: String) {
//        self.init()
//        
////        self.id = id
//        self.info = info
//        self.content = content
//    }
//}
