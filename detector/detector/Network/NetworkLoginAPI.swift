import Foundation
import Security
 
protocol NetworkLogin {
    
    func logins() -> String
    
    func authorization(password: String, login: String) -> Data?
    
    func connectionAUT(password: String, login: String, setting: String, completion: @escaping (Result<(String?, Error?), ErrorAPI>)-> Void)
}

final class NetworkLoginAPI: NetworkLogin {
    
    func logins() -> String {
        return "https://morallaugh.backendless.app/api/users/login"
    }
    
    func authorization(password: String, login: String) -> Data? {
        let authorizationUser = Authorizations(password: password, login: login)
        if let jsonData = try? JSONEncoder().encode(authorizationUser){
            return jsonData
        }
        return nil
    }
    
    func connectionAUT(password: String, login: String, setting: String, completion: @escaping (Result<(String?, Error?), ErrorAPI>)-> Void) {
        guard let url = URL(string: setting) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = AccountEnum.httpMethodPost.rawValue
        request.setValue(AccountEnum.application.rawValue, forHTTPHeaderField: AccountEnum.content.rawValue)
        request.httpBody = authorization(password: password, login: login)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.decodingError(error)))
            } else if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("Ответ: \(json ?? [:])")
                    if  let code = json?[AccountEnum.code.rawValue] as? Int, let message = json?[AccountEnum.message.rawValue] as? String {
                           return  completion(.success((message, nil)))
                        }
                    else {
                        if let token = json?[AccountEnum.token.rawValue] as? String {
                        KeychainManager.delete(account: AccountEnum.userToken.rawValue)
                        KeychainManager.save(password: token.data(using: .utf8) ?? Data(), account: AccountEnum.userToken.rawValue)
                    }

                        if let id = json?[AccountEnum.objectId.rawValue] as? String {
                            KeychainManager.delete(account: AccountEnum.userId.rawValue)
                            KeychainManager.save(password: id.data(using: .utf8) ?? Data(), account: AccountEnum.userId.rawValue)
                    }
                        return completion(.success(("", nil)))
                    }
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        task.resume()
    }
}
