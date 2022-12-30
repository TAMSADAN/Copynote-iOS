//
//  Provider.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

protocol ProviderType: AnyObject {
    var enviroment: EnvironmentType { get }
    var screen: ScreenType { get }
}

class Provider: ProviderType {
    static let shared: ProviderType = Provider()

    lazy var enviroment: EnvironmentType = Environment(provider: self)
    lazy var screen: ScreenType = Screen(provider: self)
    private init() {}
}
