//
//  PostInfo.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/31.
//  Copyright © 2022 Copynote. All rights reserved.
//

import Foundation

struct NoteInfo {
    let id: String
    var kind: Kind
    var location: Location
    var title: String
}

enum Kind: Int {
    case memo
    case url
    
    var title: String {
        switch self {
        case .memo:
            return "Memo"
            
        case .url:
            return "Url"
        }
    }
}

struct Location {
    let id: String
    let name: String
}
