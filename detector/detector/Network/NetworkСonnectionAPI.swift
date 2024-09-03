import Foundation

protocol NetworkСonnection {
    func userRegister() -> String
    func newUsers(password: String, email: String, name: String) -> Data?
    func connection(password: String, email: String, name: String, setting: String, completion: @escaping ((Result<(String?, Error?), ErrorAPI>)) -> Void)
}

final class NetworkСonnectionAPI: NetworkСonnection {
    
    func userRegister() -> String{
        return "https://morallaugh.backendless.app/api/users/register"
    }
    
    func newUsers(password: String, email: String, name: String) -> Data? {
        let registration = Registration(password: password, email: email, name: name)
        if let jsonData = try? JSONEncoder().encode(registration){
            return jsonData
        }
        return nil
    }
    
    func connection(password: String, email: String, name: String, setting: String, completion: @escaping ((Result<(String?, Error?), ErrorAPI>)) -> Void) {
        guard let url = URL(string: setting ) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = AccountEnum.httpMethodPost.rawValue
        request.setValue(AccountEnum.application.rawValue, forHTTPHeaderField: AccountEnum.content.rawValue)
        request.httpBody = newUsers(password: password, email: email, name: name)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.decodingError(error)))
            } else if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let message = json[AccountEnum.message.rawValue] as? String, let code = json[AccountEnum.code.rawValue] as? Int {
                                return  completion(.success((message, nil)))
                                }
                            else {
                                return completion(.success(("", nil)))
                            }
                        }
                    } catch {
                        completion(.failure(.decodingError(error)))
                    }
                }
        }
        
        task.resume()
    }
}
