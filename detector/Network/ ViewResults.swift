import Foundation


struct ViewResults: Decodable {
    var Name: String?
    var Lastname: String?
    var Age: String?
    var Answers: String?
}
class viewResult{
    func viewResul(token: String, userId: String, completion: @escaping ([ViewResults]?) -> Void) {
        let url = URL(string: "https://api.backendless.com/1081503C-7904-3AC8-FFD4-CBCC1CCE4A00/784F4CA1-6453-4AF1-BE87-AC0D14E81E32/data/Results?where=ownerId%3D'\(userId)'")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue(token, forHTTPHeaderField: "user-token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                let results = try JSONDecoder().decode([ViewResults].self, from: data)
                
                completion(results)
            } catch {
                let dataString = String(data: data, encoding: .utf8)
                print("Ошибка декодирования данных: \(dataString ?? "Неизвестная ошибка")")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
