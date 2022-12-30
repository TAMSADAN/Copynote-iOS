//
//  CategorySectionModel.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import RxDataSources

typealias CategorySectionModel = SectionModel<CategorySection, CategoryItem>

enum CategorySection {
    case category([CategoryItem])
}

enum CategoryItem {
    case category(CategoryCollectionViewCellReactor)
}

extension CategorySection: SectionModelType {
    typealias Item = CategoryItem
    
    var items: [Item] {
        switch self {
        case let .category(items): return items
        }
    }
    
    init(original: CategorySection, items: [CategoryItem]) {
        switch original {
        case let .category(items):
            self = .category(items)
        }
    }
}
