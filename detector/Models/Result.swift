struct Recording : Encodable{
    var name: String
    var lastname: String
    var age: String
    var answers: String
    var ownerId: String
}
struct ViewResults: Decodable {
    var Name: String?
    var Lastname: String?
    var Age: String?
    var Answers: String?
}
struct TestResult {
    var name: String
    var lastname: String
    var age: String
    var answers: String
}
