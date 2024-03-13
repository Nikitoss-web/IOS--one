//
//  OnlineRegistration.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 1.02.24.
//

import Foundation
struct Registration: Encodable{
    var password: String
    var email: String
    var name: String
}
func newUsers(password: String, email: String, name: String) -> Data? {
    let registration = Registration(password: password, email: email, name: name)
    if let jsonData = try? JSONEncoder().encode(registration){
        print(jsonData)
        return jsonData
    }
    return nil
}
