import Foundation

protocol ViewResultss {
    func viewResult(token: String, userId: String, completion: @escaping (Result<[ViewResults]?, ErrorAPI>) -> Void)
}

final class ViewResultAPI: ViewResultss {
    
    func viewResult(token: String, userId: String, completion: @escaping (Result<[ViewResults]?, ErrorAPI>) -> Void) {
        let url = URL(string: "https://api.backendless.com/1081503C-7904-3AC8-FFD4-CBCC1CCE4A00/784F4CA1-6453-4AF1-BE87-AC0D14E81E32/data/Results?where=ownerId%3D'\(userId)'")!
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
                let results = try JSONDecoder().decode([ViewResults].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(.decodingError(error)))
            }
            
        }
        task.resume()
    }
}
