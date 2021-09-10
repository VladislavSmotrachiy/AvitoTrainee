//
//  StoregeManager.swift
//  AvitoTrainee
//
//  Created by ErrorV9 on 09.09.2021.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private let key = "date"
    private let date = Date().timeIntervalSince1970
    private let defaults = UserDefaults.standard
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    private let archiveURL: URL
    
    private init() {
        archiveURL = documentDirectory.appendingPathComponent("First").appendingPathExtension("plist")
    }
    
    func checkTimerCache() -> Bool {
        guard let saveDate = defaults.object(forKey: key) as? Double
        else { return false }
        let result = date - saveDate >= 3600
        print("\(date - saveDate)")
        return result
    }
    
    func save(contact: Avito) {
        var contacts = fetchEmpolyees()
        contacts.insert(contact, at: 0)
        guard let data = try? PropertyListEncoder().encode(contacts)
        else { return }
        try? data.write(to: archiveURL, options: .noFileProtection)
        defaults.set(date, forKey: key)
    }
    
    func fetchEmpolyees() -> [Avito] {
        guard let data = try? Data(contentsOf: archiveURL) else { return [] }
        guard let cocktail = try? PropertyListDecoder().decode([Avito].self, from: data) else { return [] }
        return cocktail
    }
    
    func removeEmployees(){
        var result = fetchEmpolyees()
        result.removeAll()
        guard let data = try? PropertyListEncoder().encode(result) else { return }
        try? data.write(to: archiveURL, options: .noFileProtection)
    }
}
