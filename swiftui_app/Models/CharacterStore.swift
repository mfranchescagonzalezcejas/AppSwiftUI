//
//  CharacterStore.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 20/9/23.
//

import SwiftUI
import Combine
import Foundation

class CharacterStore: ObservableObject {
    let url = URL(string: "https://api.jikan.moe/v4/manga/13/characters")!
    
    @Published var info: [Character] = []
    
    init(info: [Character] = []) {
            self.info = info
        }
    
    func loadJikanAPI(completion: @escaping () -> Void){
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let charactersData = json["data"] as! [[String: Any]]
                
                var characters: [Character] = []
                
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
                        return
                    }
                    
                    // Download the image data asynchronously and save it to the Character object
                    if let imageURL = URL(string: image_url) {
                        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                            guard let data = data else { return }
                            DispatchQueue.main.async {
                                let newCharacter = Character(id: id, name: name, role: role, image_url: image_url, imageData: data)
                                characters.append(newCharacter)
                                
                                if characters.count == charactersData.count {
                                    self.info = characters
                                    print("-------------------- Data From API: --------------------")
//                                    print(self.toString())
                                    completion()
                                }
                            }
                        }.resume()
                    }
                }
                
            } catch {
                print("Error al obtener los datos de la API")
            }
        }
        task.resume()
    }

    
    func loadCharacterData(character: Character, completion: @escaping () -> Void){
        let url = URL(string: "https://api.jikan.moe/v4/characters/\(character.id)")!
        var about: String = ""
        var nicknames: [String] = []
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let characterData = json["data"] as! [String: Any]
                
                // Access the character data
                about = (characterData["about"] as? String)!
                nicknames = (characterData["nicknames"] as? [String])!
                
                DispatchQueue.main.async {
                    character.about = about
                    character.nicknames = nicknames
                    print(character.about ?? "none")
                    print(character.nicknames ?? "none")
                    completion()
                }
                
                
                
            } catch {
                print("Error al obtener los datos de la API")
            }
        }
        task.resume()
    }
    
    func toString() -> String {
        var string: String = ""
        info.forEach { info in
            string += "Character[\(info.toString())]"
        }
        
        return string
    }
}

extension FileManager {
    static var documentDirectoryURL: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
