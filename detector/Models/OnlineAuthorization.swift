//
//  OnlineAuthorization.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 2.02.24.
//

import Foundation
struct Authorization: Encodable{
    var password: String
    var login: String
}


func Afuthorization(password: String, login: String) -> Data?{
    let authorizationUser = Authorization(password: password, login: login)
    if let jsonDataq = try? JSONEncoder().encode(authorizationUser){
        return jsonDataq
    }
    return nil
}
