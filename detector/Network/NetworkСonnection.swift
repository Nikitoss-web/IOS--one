import Foundation

final class NetworkСonnection{
    
    func userRegister() -> String{
        return "https://morallaugh.backendless.app/api/users/register"
    }
    func newUsers(password: String, email: String, name: String) -> Data? {
        let registration = Registration(password: password, email: email, name: name)
        if let jsonData = try? JSONEncoder().encode(registration){
            print(jsonData)
            return jsonData
        }
        return nil
    }
    func connection(password: String, email: String, name: String, setting: String, completion: @escaping (String?, Error?) -> Void){
        guard let url = URL(string: setting ) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = newUsers(password: password, email: email, name: name)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print(json)
                            if let message = json["message"] as? String, let code = json["code"] as? Int {
                                print(message)
                                    return  completion(message, nil)
                                }
                            else {
                                return completion("", nil)
                            }
                        }
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
        }
        
        task.resume()
    }
}
