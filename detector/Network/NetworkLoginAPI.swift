import Foundation
import Security

final class NetworkLoginAPI{
    func logins() -> String{
        return "https://morallaugh.backendless.app/api/users/login"
    }
    func Authorization(password: String, login: String) -> Data?{
        let authorizationUser = Authorization(password: password, login: login)
        if let jsonData = try? JSONEncoder().encode(authorizationUser){
            return jsonData
        }
        return nil
    }
    func connectionAUT(password: String, login: String, setting: String, completion: @escaping (String?, Error?) -> Void){
        guard let url = URL(string: setting) else {
            print("Некорректный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = AccountEnum.httpMethodPost.rawValue
        request.setValue(AccountEnum.application.rawValue, forHTTPHeaderField: AccountEnum.content.rawValue)
        request.httpBody = Authorization(password: password, login: login)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Ошибка: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("Ответ: \(json ?? [:])")
                    if  let code = json?[AccountEnum.code.rawValue] as? Int, let message = json?[AccountEnum.message.rawValue] as? String {
                        print(message)
                           return  completion(message, nil)
                        }
                    else {
                        if let token = json?[AccountEnum.userToken.rawValue] as? String {
                        KeychainManager.delete(account: AccountEnum.userToken.rawValue)
                        KeychainManager.save(password: token.data(using: .utf8) ?? Data(), account: AccountEnum.userToken.rawValue)
                    }

                        if let id = json?[AccountEnum.objectId.rawValue] as? String {
                            KeychainManager.delete(account: AccountEnum.userId.rawValue)
                            KeychainManager.save(password: id.data(using: .utf8) ?? Data(), account: AccountEnum.userId.rawValue)
                    }
                        return completion("", nil)
                    }
                } catch {
                    print("Ошибка: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
}
