struct Registration: Encodable {
    var password: String
    var email: String
    var name: String
}

struct Authorizations: Encodable {
    var password: String
    var login: String
}

