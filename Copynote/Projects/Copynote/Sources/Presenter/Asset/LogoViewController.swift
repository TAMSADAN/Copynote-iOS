//
//  LogoViewController.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit

class LogoViewController: BaseViewController {
    // MARK: - UI Components

    let logoView: UIView = .init()
    let logoLabel: UILabel = .init()
    let contentView: UIView = .init()

    override func setupProperty() {
        super.setupProperty()

        logoLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 20)
        logoLabel.text = "copy note ."
    }

    override func setupHierarchy() {
        super.setupHierarchy()

        view.addSubviews([logoView, contentView])
        logoView.addSubviews([logoLabel])
    }

    override func setupLayout() {
        super.setupLayout()

        logoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }

        logoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
