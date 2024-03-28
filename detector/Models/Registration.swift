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
struct Authorization: Encodable{
    var password: String
    var login: String
}

