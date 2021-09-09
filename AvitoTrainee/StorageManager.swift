//
//  StoregeManager.swift
//  AvitoTrainee
//
//  Created by ErrorV9 on 09.09.2021.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private let defaults = UserDefaults.standard
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let archiveURL: URL
    private init() {
        archiveURL = documentDirectory.appendingPathComponent("First").appendingPathExtension("plist")
    }
    
    func save(contact: Avito) {
          var contacts = fetchContacts()
          contacts.insert(contact, at: 0)
          guard let data = try? PropertyListEncoder().encode(contacts) else { return }
          try? data.write(to: archiveURL, options: .noFileProtection)
          print("Сохранил" )
      }
      
      func fetchContacts() -> [Avito] {
          guard let data = try? Data(contentsOf: archiveURL) else { return [] }
          guard let cocktail = try? PropertyListDecoder().decode([Avito].self, from: data) else { return [] }
          print("получил")
          return cocktail
      }
}
