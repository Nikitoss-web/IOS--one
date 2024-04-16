struct Recording : Encodable {
    var name: String
    var lastname: String
    var age: String
    var answers: String
    var ownerId: String
}

struct ViewResults: Decodable {
    var name: String?
    var lastname: String?
    var age: String?
    var answers: String?
}

struct TestResult {
    var name: String
    var lastname: String
    var age: String
    var answers: String
}
