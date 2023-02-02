//
//  SelectLocationSection.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/24.
//  Copyright © 2023 Copynote. All rights reserved.
//

import RxDataSources

typealias SelectLocationSectionModel = SectionModel<SelectLocationSection, SelectLocationItem>

enum SelectLocationSection {
    case location([SelectLocationItem])
}

enum SelectLocationItem {
    case location(SelectLocationCollectionViewCellReactor)
}

extension SelectLocationSection: SectionModelType {
    typealias Item = SelectLocationItem
    
    var items: [Item] {
        switch self {
        case let .location(items):
            return items
        }
    }
    
    init(original: SelectLocationSection, items: [SelectLocationItem]) {
        switch original {
        case let .location(items):
            self = .location(items)
        }
    }
}
