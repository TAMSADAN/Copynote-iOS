//
//  Enviroment.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/31.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

protocol EnvironmentType: AnyObject {
    var version: String { get }
}

class Environment: BaseProvider, EnvironmentType {
    var version: String {
        CopynoteResources.bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}
