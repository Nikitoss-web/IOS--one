import Foundation

struct Questions1: Decodable {
    var Questions: String
    var objectId: String
}

struct QuestionResponse: Decodable {
    var question: [Questions1]
    var created: Int
    var name_test: String
    var ownerId: String?
    var updated: Int?
}
class OnlineNameTest{
    func fetchDataFromAPI(objectId: String, token: String, completion: @escaping ([String]?) -> Void) {
        guard let url = URL(string: "https://api.backendless.com/1081503C-7904-3AC8-FFD4-CBCC1CCE4A00/784F4CA1-6453-4AF1-BE87-AC0D14E81E32/data/NameTest/\(objectId)?loadRelations=question") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(token, forHTTPHeaderField: "user-token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(QuestionResponse.self, from: data)
                CoreDataService.shared.saveNameTest(with: response)
                let questions = response.question.map { $0.Questions }
                print("Ответ: \(response)")
                completion(questions)
            } catch {
                print("Error parsing JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
