//
//  NetworkManager.swift
//  AvitoTrainee
//
//  Created by ErrorV9 on 08.09.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, with complition: @escaping (Avito) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        if StorageManager.shared.timerCache() == false {
            if let cache = StorageManager.shared.fetchContacts().first  {
                complition(cache)
                return
            } else {
                URLSession.shared.dataTask(with: url) {(data, response,error) in
                    guard let data = data, let response = response else {
                        print(error?.localizedDescription ?? "No error description")
                        return
                    }
                    do {
                        guard url == response.url else { return }
                        let cocktail = try JSONDecoder().decode(Avito.self, from: data)
                        StorageManager.shared.save(contact: cocktail)
                        DispatchQueue.main.async {
                            complition(cocktail)
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }.resume()
            }
        }
    }
}
