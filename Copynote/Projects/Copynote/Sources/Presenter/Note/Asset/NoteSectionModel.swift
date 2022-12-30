//
//  PostSectionModel.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import RxDataSources

typealias NoteSectionModel = SectionModel<NoteSection, NoteItem>

enum NoteSection {
    case kind([NoteItem])
    case post([NoteItem])
}

enum NoteItem {
    case kind(KindCollectionViewCellReactor)
    case post(PostCollectionViewCellReactor)
}

extension NoteSection: SectionModelType {
    typealias Item = NoteItem
    
    var items: [Item] {
        switch self {
        case let .kind(items):
            return items
            
        case let .post(items):
            return items
        }
    }
    
    init(original: NoteSection, items: [NoteItem]) {
        switch original {
        case let .kind(items):
            self = .kind(items)
            
        case let .post(items):
            self = .post(items)
        }
    }
}
