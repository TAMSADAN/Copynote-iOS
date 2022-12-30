//
//  TagStackView.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit

class KindStackView: UIStackView {
    // MARK: - Properties

    var kinds: [Kind] = [] {
        didSet {
            setupProperty()
        }
    }
    
    init() {
        super.init(frame: .zero)
        distribution = .fillProportionally
        spacing = 10
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(kinds: [Kind]) {
        self.kinds = kinds
    }

    func setupProperty() {
        subviews.forEach({ $0.removeFromSuperview() })

        for kind in kinds {
            let kindView: KindView = .init(kind: kind)

            addArrangedSubview(kindView)
        }
    }
}

class KindView: BaseView {
    // MARK: - Properties

    let kind: Kind

    // MARK: - UI Components

    let titleLabel: UILabel = .init()

    // MARK: - Initializer

    init(kind: Kind) {
        self.kind = kind
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupProperty() {
        super.setupProperty()

        cornerRound(radius: 12)
        makeBorder(color: .black, width: 1)
        
        titleLabel.text = kind.title
        titleLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 13)
    }

    override func setupHierarchy() {
        super.setupHierarchy()

        addSubviews([titleLabel])
    }
    
    override func setupLayout() {
        super.setupLayout()

        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(7)
        }
    }
}
