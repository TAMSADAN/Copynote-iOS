//
//  Provider.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation
import RealmSwift

protocol ProviderType: AnyObject {
    var enviroment: EnvironmentProviderType { get }
    var screen: ScreenProviderType { get }
    var realm: Realm { get }
}

class Provider: ProviderType {
    static let shared: ProviderType = Provider()

    lazy var enviroment: EnvironmentProviderType = EnvironmentProvider(provider: self)
    lazy var screen: ScreenProviderType = ScreenProvider(provider: self)
    lazy var realm: Realm = try! Realm()
    
    private init() {}
}
