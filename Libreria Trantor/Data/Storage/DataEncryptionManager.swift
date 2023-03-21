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

class DataEncryptionManager {
    static let shared = DataEncryptionManager()
    
    private init() {}
    
    func save<T: Codable>(_ item: T, key: StorageKeys) throws {
        do {
            let data = try JSONEncoder().encode(item)
            let symmetricKey = readSymmetricKey()
            let sealedBox = try AES.GCM.seal(data, using: symmetricKey)
            if let encryptedData = sealedBox.combined {
                try saveData(encryptedData, key: key)
                print("Save data encrypted \(key.rawValue)")
            } else {
                throw StorageError.savingFailed
            }
            
        } catch {
            print("Fail to encode item for keychain: \(error)")
            throw StorageError.encodingFailed
        }
    }


    func get<T: Codable>(key: StorageKeys, type: T.Type) -> T?  {
        guard let data = read(key) else {
            return nil
        }
        guard let symmetricKeyData = read(.symmetrickey) else {
            return nil
        }
        let symmetricKey = SymmetricKey(data: symmetricKeyData)
        
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
            let item = try JSONDecoder().decode(type, from: decryptedData)
            return item
        } catch let error as CryptoKit.CryptoKitError {
               switch error {
               case .authenticationFailure:
                   print("Authentication failure: the authentication tag in the encrypted data is invalid.")
                   return nil
               default:
                   print("Fail to decode item for keychain: \(error) | \(error.localizedDescription)")
                   return nil
               }
           } catch {
               print("Fail to decode item for keychain: \(error) | \(error.localizedDescription)")
               return nil
           }
    }
    
    
    func remove(_ key: StorageKeys) {
        let query = [
            kSecAttrService: KeychainConfiguration.service,
            kSecAttrAccount: key.rawValue,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        SecItemDelete(query)
        print("removed \(key.rawValue) from DataEncryptionManager")
    }
    
    func cleanAll() {
        StorageKeys.allCases.forEach { remove($0) }
    }
}

private extension DataEncryptionManager {
    func saveData(_ data: Data, key: StorageKeys) throws {
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
    
    private func saveSymetricKey(_ symmetricKey:SymmetricKey) throws {
        let data = symmetricKey.withUnsafeBytes { Data($0) }
        try saveData(data, key: StorageKeys.symmetrickey)
    }
    private func readSymmetricKey()-> SymmetricKey {
        guard let symmetricKeyData = read(.symmetrickey) else {
            let newSymmetricKey = SymmetricKey(size: .bits256)
            try! saveSymetricKey(newSymmetricKey)
            return newSymmetricKey
        }
        return SymmetricKey(data: symmetricKeyData)
    }
}
