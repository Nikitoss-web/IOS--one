import Foundation
class RecordingResults{
    
    func results() -> String{
        return "https://api.backendless.com/1081503C-7904-3AC8-FFD4-CBCC1CCE4A00/784F4CA1-6453-4AF1-BE87-AC0D14E81E32/data/Results"
    }
    func RecordingResult(recording: Recording, userId: String, token: String) {
        guard let url = URL(string: results()) else {
            print("Некорректный URL")
            return
        }
        var recording = recording
        recording.ownerId = userId 
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(token, forHTTPHeaderField: "user-token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode(recording)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Ошибка: \(error.localizedDescription)")
                } else if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        print("Ответ: \(json ?? [:])")
                    } catch {
                        print("Ошибка: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        } catch {
            print("Ошибка при кодировании данных: \(error.localizedDescription)")
        }
    }
    
}
