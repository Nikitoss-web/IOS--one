
enum Screen: String {
    case mainStoryboard = "MainStoryboard"
    case allTestStoryboard = "AllTestStoryboard"
    case timersView = "TimersView"
    case testUserRegistration = "TestUserRegistration"
    case resultStoryboard = "ResultsStoryboard"
    case main = "Main"
}

enum CellIdentifier: String {
    case yourCellIdentifier = "YourCellIdentifier"
    case yourCellIdentifier1 = "YourCellIdentifier1"
    case yourCellIdentifier3 = "YourCellIdentifier3"
}

enum SearchFormatBases: String {
    case name_testObjectId = "name_test == %@ AND objectId == %@"
    case objectId = "objectId == %@"
    case ownerId = "ownerId == %@"
    case questionsOwnerId = "questions == %@ AND ownerId == %@"
}

enum AccountEnum: String {
    case userId = "userId"
    case userToken = "userToken"
    case objectId = "objectId"
    case token = "user-token"
    case application = "application/json"
    case content = "Content-Type"
    case httpMethodGet = "GET"
    case httpMethodPost = "POST"
    case code = "code"
    case message = "message"
}

enum TestResultEnum: String {
    case messageStart = "start"
    case messageStop = "stop"
    case resultTruth = "Truth"
    case resultLie = "Lie"
    case yes = "Yes"
    case no = "No"
}

