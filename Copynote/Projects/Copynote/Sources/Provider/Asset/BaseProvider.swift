//
//  BaseProvider.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

class BaseProvider {
    unowned let provider: ProviderType

    init(provider: ProviderType) {
        self.provider = provider
    }
}
