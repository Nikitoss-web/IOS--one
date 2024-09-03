import Foundation

protocol OnlineNameTest {
    
    func fetchDataFromAPI(objectId: String, token: String, completion: @escaping ((Result<[String]?, ErrorAPI>)) -> Void)
}

class OnlineNameTestAPI: OnlineNameTest {
    
    func fetchDataFromAPI(objectId: String, token: String, completion: @escaping ((Result<[String]?, ErrorAPI>)) -> Void) {
        guard let url = URL(string: "https://api.backendless.com/1081503C-7904-3AC8-FFD4-CBCC1CCE4A00/784F4CA1-6453-4AF1-BE87-AC0D14E81E32/data/NameTest/\(objectId)?loadRelations=question") else {
            print("Invalid URL")
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = AccountEnum.httpMethodGet.rawValue
        request.addValue(token, forHTTPHeaderField: AccountEnum.token.rawValue)
        request.addValue(AccountEnum.application.rawValue, forHTTPHeaderField: AccountEnum.content.rawValue)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.decodingError(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let response = try JSONDecoder().decode(QuestionResponse.self, from: data)
                CoreDataService.shared.saveNameTest(with: response)
                let questions = response.question.map { $0.questions}
                completion(.success(questions))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}
