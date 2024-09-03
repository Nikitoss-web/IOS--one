import Foundation

protocol RecordingResults {
    func results() -> String
    func recordingResult(recording: Recording, userId: String, token: String)
}

class RecordingResultsAPI: RecordingResults {
    
    func results() -> String {
        return "https://api.backendless.com/1081503C-7904-3AC8-FFD4-CBCC1CCE4A00/784F4CA1-6453-4AF1-BE87-AC0D14E81E32/data/Results"
    }
    
    func recordingResult(recording: Recording, userId: String, token: String) {
        guard let url = URL(string: results()) else {
            return 
        }
        var recording = recording
        recording.ownerId = userId 
        var request = URLRequest(url: url)
        request.httpMethod = AccountEnum.httpMethodPost.rawValue
        request.addValue(token, forHTTPHeaderField: AccountEnum.token.rawValue)
        request.setValue(AccountEnum.application.rawValue, forHTTPHeaderField: AccountEnum.content.rawValue)
        do {
            let jsonData = try JSONEncoder().encode(recording)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                } else if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    } catch {
                    }
                }
            }
            task.resume()
        } catch {
        }
    }
    
}
