//
//  UserCredentialStorage.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 10/3/23.
//

import Foundation
import CryptoKit


enum StorageError: Error {
    case encodingFailed
    case savingFailed
    case decodingFailed
    case duplicateItem
}

class Storage {
    static let shared = Storage()
    
    private init() {}
    
    func save<T: Codable>(_ item: T, key: StorageKeys) throws {
        do {
            let data = try JSONEncoder().encode(item)
            let symmetricKey = SymmetricKey(size: .bits256)
            let sealedBox = try AES.GCM.seal(data, using: symmetricKey)
            let encryptedData = sealedBox.combined
            try save(encryptedData, key: key)
        } catch {
//            assertionFailure("Fail to encode item for keychain: \(error)")
            throw StorageError.encodingFailed
        }
    }


    func get<T: Codable>(key: StorageKeys, type: T.Type) -> T?  {
        guard let data = read(key) else {
            return nil
        }
        
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let symmetricKey = SymmetricKey(size: .bits256)
            let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
            let item = try JSONDecoder().decode(type, from: decryptedData)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
//            throw StorageError.decodingFailed
        }
    }
    
    
    func remove(_ key: StorageKeys) {
        let query = [
            kSecAttrService: KeychainConfiguration.service,
            kSecAttrAccount: key.rawValue,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        SecItemDelete(query)
    }
    
    func cleanAll() {
        StorageKeys.allCases.forEach { remove($0) }
    }
}





class SecureStorage {
    static let shared = SecureStorage()
    
    private init() {}
    
    func save<T: Codable>(_ item: T, key: StorageKeys) throws {
        do {
            let data = try JSONEncoder().encode(item)
            try save(data, key: key)
        } catch {
            throw StorageError.encodingFailed
        }
    }

//    func get<T: Codable>(key: StorageKeys, type: T.Type) -> T? {
//        guard let data = read(key) else {
//            return nil
//        }
//
//        do {
//            let item = try JSONDecoder().decode(type, from: data)
//            return item
//        } catch {
//            assertionFailure("Fail to decode item for keychain: \(error)")
//            return nil
//        }
//    }
//    
    func remove(_ key: StorageKeys) {
        let query = [
            kSecAttrService: KeychainConfiguration.service,
            kSecAttrAccount: key.rawValue,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        SecItemDelete(query)
    }
    
    func cleanAll() {
        StorageKeys.allCases.forEach { remove($0) }
    }
}

private extension Storage {
    func save(_ data: Data, key: StorageKeys) throws {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: KeychainConfiguration.service,
            kSecAttrAccount: key.rawValue,
        ] as CFDictionary
        
        var status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            let query = [
                kSecAttrService: KeychainConfiguration.service,
                kSecAttrAccount: key.rawValue,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            status = SecItemUpdate(query, attributesToUpdate)
            if status != errSecSuccess {
                throw StorageError.savingFailed
            }
        } else if status != errSecSuccess {
            throw StorageError.savingFailed
        }
    }
    
    func read(_ key: StorageKeys) -> Data? {
        let query = [
            kSecAttrService: KeychainConfiguration.service,
            kSecAttrAccount: key.rawValue,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
}

/*

func save<T: Codable>(_ item: T, key: StorageKey) throws {
    do {
        let data = try JSONEncoder().encode(item)
        try save(data, key: key)
    } catch {
        throw StorageError.encodingError(error)
    }
}

private extension Storage {
    func save(_ data: Data, key: StorageKey) throws {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: KeychainConfiguration.service,
            kSecAttrAccount: key.rawValue,
        ] as CFDictionary

        let status = SecItemAdd(query, nil)

        if status != errSecSuccess {
            if status == errSecDuplicateItem {
                let query = [
                    kSecAttrService: KeychainConfiguration.service,
                    kSecAttrAccount: key.rawValue,
                    kSecClass: kSecClassGenericPassword,
                ] as CFDictionary

                let attributesToUpdate = [kSecValueData: data] as CFDictionary
                let updateStatus = SecItemUpdate(query, attributesToUpdate, nil)
                if updateStatus != errSecSuccess {
                    throw StorageError.keychainError(updateStatus)
                }
            } else {
                throw StorageError.keychainError(status)
            }
        }
    }
}

*/
