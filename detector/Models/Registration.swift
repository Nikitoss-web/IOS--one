struct Registration: Encodable{
    var password: String
    var email: String
    var name: String
}
struct Authorization: Encodable{
    var password: String
    var login: String
}

