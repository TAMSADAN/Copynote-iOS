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
    case all = 0
    case memo = 1
    case url = 2
    
    var title: String {
        switch self {
        case .all:
            return "all"
            
        case .memo:
            return "memo"
            
        case .url:
            return "url"
        }
    }
    
    func toDomain() -> Kind {
        switch self {
        case .all:
            return .memo
            
        default:
            return self
        }
    }
}
