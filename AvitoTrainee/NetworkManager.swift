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
    
    private func fetchNetworkData(url: URL, with complition: @escaping (Avito) -> Void) {
         URLSession.shared.dataTask(with: url) {(data, response,error) in
             guard let data = data, let response = response else {
                 print(error?.localizedDescription ?? "No error description")
                 return
             }
             do {
                 guard url == response.url else { return }
                 let empolyee = try JSONDecoder().decode(Avito.self, from: data)
                 StorageManager.shared.save(contact: empolyee)
                 DispatchQueue.main.async {
                     complition(empolyee)
                 }
             } catch let error {
                 print(error.localizedDescription)
             }
         }.resume()
     }
    
    func fetchData(from url: String?, with complition: @escaping (Avito) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        if StorageManager.shared.checkTimerCache() == false {
            if let cache = StorageManager.shared.fetchEmpolyees().first {
                complition(cache)
                return
            } else {
                fetchNetworkData(url: url, with: complition)
            }
        } else {
            StorageManager.shared.removeEmployees()
            fetchNetworkData(url: url, with: complition)
        }
    }
   
}
