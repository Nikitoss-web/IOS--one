import Foundation

struct NameTestResponse: Decodable {
    var data: [NameTest1]
}

struct NameTest1: Decodable {
    var objectId: String
}
class RequestOnline{
    func fetchObjectIdFromName() {
        guard let url = URL(string: "https://api.backendless.com/1081503C-7904-3AC8-FFD4-CBCC1CCE4A00/784F4CA1-6453-4AF1-BE87-AC0D14E81E32/data/NameTest?where=Name='Test_two'") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(NameTestResponse.self, from: data)
                
                if let nameTest = responseData.data.first {
                    print(nameTest)
                    print("!!!!!!!objectId for item with name 'Test_two': \(nameTest.objectId)")
                } else {
                    print("Item with name 'Test_two' not found")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        
        task.resume()
    }
}
