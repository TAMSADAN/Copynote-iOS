//
//  UIStackView+Ext.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }

    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
    }
}
