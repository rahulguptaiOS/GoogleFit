//
//  KeychainManager.swift
//  GFitStepCount
//
//  Created by Gupta, Rahul @ Gurgaon on 24/07/21.
//

import Foundation
import Security

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

class KeychainManager: NSObject {
    static func save(item: String) throws {
        if let valueData = item.data(using: .utf8) {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecValueData as String: valueData]
        SecItemDelete(query as CFDictionary) 
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        }
    }
    
    static func getAuthToken() throws -> String {
        var item: CFTypeRef?
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        guard let existingItem = item as? [String : Any],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8)
        else {
            throw KeychainError.unexpectedPasswordData
        }
        
        return password
    }
}
