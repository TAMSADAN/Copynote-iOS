//
//  Enviroment.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/31.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

protocol EnvironmentProviderType: AnyObject {
    var version: String { get }
}

class EnvironmentProvider: BaseProvider, EnvironmentProviderType {
    var version: String {
        CopynoteResources.bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}
