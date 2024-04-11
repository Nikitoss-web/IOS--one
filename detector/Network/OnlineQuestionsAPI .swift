import Foundation

class OnlineQuestionAPI{
    func fetchDataFromBackendless(token: String, completion: @escaping ([Test]?) -> Void) {
        let url = URL(string: "https://api.backendless.com/1081503C-7904-3AC8-FFD4-CBCC1CCE4A00/784F4CA1-6453-4AF1-BE87-AC0D14E81E32/data/NameTest")!
        var request = URLRequest(url: url)
        request.httpMethod = AccountEnum.httpMethodGet.rawValue
        request.addValue(token, forHTTPHeaderField: AccountEnum.token.rawValue)
        request.addValue(AccountEnum.application.rawValue, forHTTPHeaderField: AccountEnum.content.rawValue)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Ошибка: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("Ошибка: Отсутствует data")
                completion(nil)
                return
            }
            do {
                let tests = try JSONDecoder().decode([Test].self, from: data)
                
                CoreDataService.shared.saveQuestions(with: tests)
                
                completion(tests)
            } catch {
                let dataString = String(data: data, encoding: .utf8)
                print("Ошибка декодирования данных: \(dataString ?? "Неизвестная ошибка")")
                completion(nil)
            }
        }
        task.resume()
    }
    
}






