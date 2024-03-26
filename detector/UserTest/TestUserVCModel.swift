import Foundation
class TestUserVCViewModel {
    private let resultsRecording = RecordingResults()
    private let simpleBluetoothIO = BluetoothManager()

    func saveTestResult(name: String, lastname: String, age: String, questions: [String], answers: [String]) {
        let combinedArray = Array(zip(questions, answers)).flatMap { [$0, $1] }
        let combinedString = combinedArray.joined(separator: " ")
        
        let result = TestResult(name: name, lastname: lastname, age: age, answers: combinedString)
        
        let recording = Recording(name: result.name, lastname: result.lastname, age: result.age, answers: result.answers, ownerId: String(decoding: KeychainManager.getPassword(for: "userId") ?? Data(), as: UTF8.self))
        
        resultsRecording.RecordingResult(recording: recording, userId: String(decoding: KeychainManager.getPassword(for: "userId") ?? Data(), as: UTF8.self), token: String(decoding: KeychainManager.getPassword(for: "userToken") ?? Data(), as: UTF8.self))
    }
}
