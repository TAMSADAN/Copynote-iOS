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
    let logoDivider: UIView = .init()
    let contentView: UIView = .init()

    override func setupProperty() {
        super.setupProperty()

        logoLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 20)
        logoLabel.text = "copy note ."

        logoDivider.backgroundColor = .black
    }

    override func setupHierarchy() {
        super.setupHierarchy()

        view.addSubviews([logoView, contentView])
        logoView.addSubviews([logoLabel, logoDivider])
    }

    override func setupLayout() {
        super.setupLayout()

        logoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }

        logoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        logoDivider.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        contentView.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
