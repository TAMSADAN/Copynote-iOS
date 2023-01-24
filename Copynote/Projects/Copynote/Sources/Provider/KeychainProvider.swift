//
//  KeychainProvider.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/14.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import KeychainAccess

enum KeychainAccessKey: String {
    case fixedId
}

protocol KeychainProviderType: AnyObject {
    var keychain: Keychain { get }
    
    func get(key: KeychainAccessKey) -> String?
    func set(key: KeychainAccessKey, value: String)
    func remove(key: KeychainAccessKey)
}

class KeychainProvider: BaseProvider, KeychainProviderType {
    override init(provider: ProviderType) {
        super.init(provider: provider)
        
        if get(key: .fixedId) == nil {
            set(key: .fixedId, value: UUID().uuidString)
        }
    }
    
    var keychain: Keychain {
        return Keychain(service: "tamsadan.copynote")
    }
    
    func get(key: KeychainAccessKey) -> String? {
        return self.keychain[key.rawValue]
    }
    
    func set(key: KeychainAccessKey, value: String) {
        do {
            try self.keychain.set(value, key: key.rawValue)
        } catch {
            print(error)
        }
    }
    
    func remove(key: KeychainAccessKey) {
        do {
            try self.keychain.remove(key.rawValue)
        } catch {
            print(error)
        }
    }
}
