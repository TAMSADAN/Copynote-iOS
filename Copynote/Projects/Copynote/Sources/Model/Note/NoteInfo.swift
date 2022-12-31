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
}

//class NoteInfoRealm: Object {
//    @Persisted var id: String
//    @Persisted var kind: Kind
//    @Persisted var location: String
//    @Persisted var title: String
//    
//    convenience init(kind: Kind, location: String, title: String) {
//        self.init()
//        
//        self.id = id
//        self.kind = kind
//        self.location = location
//        self.title = title
//    }
//}
