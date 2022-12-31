//
//  Kind.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/31.
//  Copyright © 2022 Copynote. All rights reserved.
//

import Foundation
import RealmSwift

enum Kind: Int, Codable, CaseIterable, PersistableEnum {
    case memo = 0
    case url = 1
    
    var title: String {
        switch self {
        case .memo:
            return "Memo"
            
        case .url:
            return "Url"
        }
    }
}
