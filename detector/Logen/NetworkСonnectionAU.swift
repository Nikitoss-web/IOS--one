//  NetworkСonnectionAUT.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 2.02.24.
//

import Foundation
import Security

final class NetworkСonnectionAU{
    func logins() -> String{
        return "https://morallaugh.backendless.app/api/users/login"
    }
    func connectionAUT(password: String, login: String, setting: String, completion: @escaping (String?, Error?) -> Void){
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
                print("Ошибка: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("Ответ: \(json ?? [:])")
                    if let token = json?["user-token"] as? String {
                        KeychainManager.delete(account: "userToken")
                        KeychainManager.save(password: token.data(using: .utf8) ?? Data(), account: "userToken")
                    }

                    if let id = json?["objectId"] as? String {
                        KeychainManager.delete(account: "userId")
                        KeychainManager.save(password: id.data(using: .utf8) ?? Data(), account: "userId")
                    }
                    if  let code = json?["code"] as? Int, let message = json?["message"] as? String {
                        print(message)
                           return  completion(message, nil)
                        }
                    else {
                        return completion("", nil)
                    }
                  
                    
                } catch {
                    print("Ошибка: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
}

