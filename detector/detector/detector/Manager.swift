//
//  Manager.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 6.02.24.
//

import Foundation

class APIManager{
    static let shared = APIManager()
    let urlString = "https://api.backendless.com/1081503C-7904-3AC8-FFD4-CBCC1CCE4A00/784F4CA1-6453-4AF1-BE87-AC0D14E81E32/data/NameTest"
    
    func getWeather(){
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){data, response, error in
            print(response)}
        
        
        task.resume()
    }
}
