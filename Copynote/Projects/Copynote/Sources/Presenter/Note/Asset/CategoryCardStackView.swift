//
//  CategoryCardStackView.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit

class CategoryCardStackView: UIStackView {
    // MARK: - Properties

    var categories: [Category] = [] {
        didSet {
            setupProperty()
        }
    }

    func update(categories: [Category]) {
        self.categories = categories
    }

    func setupProperty() {
        subviews.forEach({ $0.removeFromSuperview() })

        for category in categories {
            let categoryCardView: CategoryCardView = .init(category: category)

            addArrangedSubview(categoryCardView)
        }
    }
}

class CategoryCardView: BaseView {
    // MARK: - Properties

    let category: Category

    // MARK: - UI Components

    let titleLabel: UILabel = .init()

    // MARK: - Initializer

    init(category: Category) {
        self.category = category
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupProperty() {
        super.setupProperty()

        cornerRound(radius: 20)

        titleLabel.text = category.title
    }

    override func setupLayout() {
        super.setupLayout()

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
        }
    }

    override func setupHierarchy() {
        super.setupHierarchy()

        addSubviews([titleLabel])
    }
}
