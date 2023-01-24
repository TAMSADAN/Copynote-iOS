//
//  SelectKindSectionModel.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import RxDataSources

typealias SelectKindSectionModel = SectionModel<SelectKindSection, SelectKindItem>

enum SelectKindSection {
    case kind([SelectKindItem])
}

enum SelectKindItem {
    case kind(SelectKindCollectionViewCellReactor)
}

extension SelectKindSection: SectionModelType {
    typealias Item = SelectKindItem
    
    var items: [Item] {
        switch self {
        case let .kind(items):
            return items
        }
    }
    
    init(original: SelectKindSection, items: [SelectKindItem]) {
        switch original {
        case let .kind(items):
            self = .kind(items)
        }
    }
}
