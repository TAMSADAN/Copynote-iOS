//
//  Screen.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit

protocol ScreenProviderType: AnyObject {
    var width: CGFloat { get }
    var height: CGFloat { get }
}

class ScreenProvider: BaseProvider, ScreenProviderType {
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }

    var height: CGFloat {
        return UIScreen.main.bounds.height
    }
}
