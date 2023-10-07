//
//  DatabaseImpl.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 3/10/23.
//

import Foundation

class DatabaseImpl: Database {
        // cambiar  Datbase  Networ y NetworkImpl
    func getItemsList() async throws -> [CharacterVO] {
        let url = URL(string: "https://api.jikan.moe/v4/manga/13/characters")!
        var characters: [CharacterVO] = []
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let charactersData = json["data"] as! [[String: Any]]
        
        for character in charactersData {
            let characterData = character["character"] as! [String: Any]
            let characterRole = character["role"]!
            let characterImage = characterData["images"] as! [String: Any]
            let characterImageURL = characterImage["jpg"] as! [String: Any]
            
            guard let id = characterData["mal_id"] as? Int64,
                  let name = characterData["name"] as? String,
                  let role = characterRole as? String,
                  let image_url = characterImageURL["image_url"] as? String
            else {
                throw NSError(domain: "", code: 0, userInfo: nil) // Proporciona un error más descriptivo aquí
            }
            
            // Download the image data asynchronously and save it to the Character object
            if let imageURL = URL(string: image_url) {
                let (data, _) = try await URLSession.shared.data(from: imageURL)
                let newCharacter = CharacterVO(id: id, name: name, role: role, image_url: image_url, imageData: data)
                characters.append(newCharacter)
            }
        }
        
        return characters
    }


    
    func getItemByID(id: Int64) async throws -> CharacterVO? {
        let url = URL(string: "https://api.jikan.moe/v4/characters/\(id)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let characterData = json["data"] as! [String: Any]
        
        // Access the character data
        let about = characterData["about"] as? String
        let nicknames = characterData["nicknames"] as? [String]
        
        return CharacterVO(id: id, name: "", role: "", image_url: "", nicknames: nicknames, about: about)
    }

    

}
