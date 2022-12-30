//
//  CategorySectionModel.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import RxDataSources

typealias LocationSectionModel = SectionModel<LocationSection, LocationItem>

enum LocationSection {
    case location([LocationItem])
}

enum LocationItem {
    case location(LocationCollectionViewCellReactor)
}

extension LocationSection: SectionModelType {
    typealias Item = LocationItem
    
    var items: [Item] {
        switch self {
        case let .location(items): return items
        }
    }
    
    init(original: LocationSection, items: [LocationItem]) {
        switch original {
        case let .location(items):
            self = .location(items)
        }
    }
}
