//
//  NetworkСonnection.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 1.02.24.
//

import Foundation

final class NetworkСonnection{
    
    func userRegister() -> String{
        return "https://morallaugh.backendless.app/api/users/register"
    }
    
    
    func connection(password: String, email: String, name: String, setting: String){
        guard let url = URL(string: setting ) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = newUsers(password: password, email: email, name: name)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("Response: \(json ?? [:])")
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
}
