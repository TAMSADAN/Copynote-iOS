//
//  Screen.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit

protocol ScreenType: AnyObject {
    var width: CGFloat { get }
    var height: CGFloat { get }
}

class Screen: BaseProvider, ScreenType {
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }

    var height: CGFloat {
        return UIScreen.main.bounds.height
    }
}
