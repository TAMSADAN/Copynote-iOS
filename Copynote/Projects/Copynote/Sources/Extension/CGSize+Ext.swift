//
//  CGSize+Ext.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit

extension CGSize {
    func text(_ text: String, font: UIFont) -> Self {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: fontAttributes)
        return size
    }
}
