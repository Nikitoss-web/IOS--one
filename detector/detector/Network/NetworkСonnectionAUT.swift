//
//  NetworkСonnectionAUT.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 2.02.24.
//

import Foundation
import Security

final class NetworkСonnectionAUT{
    func logins() -> String{
        return "https://morallaugh.backendless.app/api/users/login"
    }
    func connectionAUT(password: String, login: String, setting: String){
        guard let url = URL(string: setting) else {
            print("Некорректный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = Afuthorization(password: password, login: login)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // Обработка ошибки соединения или запроса
                print("Ошибка: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    if let token = json?["user-token"] as? String {
                        KeychainManager.delete(account: "userToken") // Удаляем существующий токен, если он есть
                        KeychainManager.save(password: token.data(using: .utf8) ?? Data(), account: "userToken")
                    }

                    if let id = json?["objectId"] as? String {
                        KeychainManager.delete(account: "userId") // Удаляем существующий идентификатор, если он есть
                        KeychainManager.save(password: id.data(using: .utf8) ?? Data(), account: "userId")
                    }
                    
                    print("Ответ: \(json ?? [:])")
                    
                } catch {
                    print("Ошибка: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
}
