import Foundation
import Security

final class KeychainManager {
    static func save(password: Data, account: String) {
            let query: [CFString: Any] = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: account,
                kSecAttrService: "YourServiceName",
                kSecValueData: password,
                kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked
            ]
            let status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                print("Ошибка при сохранении данных в Keychain. Status code: \(status)")
            }
        }
    static func getPassword(for account: String) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        var results: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &results)
        if status != errSecSuccess {
            print("Ошибка при получении данных из Keychain")
            return nil
        }
        if let data = results as? Data, let password = String(data: data, encoding: .utf8) {
            return password
        } else {
            return nil
        }
    }
            static func delete(account: String) {
           let query: [CFString: Any] = [
               kSecClass: kSecClassGenericPassword,
               kSecAttrAccount: account
           ]
           let status = SecItemDelete(query as CFDictionary)
           if status != errSecSuccess && status != errSecItemNotFound {
               print("Failed to delete keychain item with account: \(account)")
           }
       }
}
