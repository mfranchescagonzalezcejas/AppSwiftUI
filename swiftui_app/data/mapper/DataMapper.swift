//
//  DataMapper.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 3/10/23.
//

import Foundation

extension CharacterVO {
    func toModel() -> Character {
        return Character(id: id, name: name, role: role, image_url: image_url, imageData: imageData, nicknames: nicknames, about: about)
    }
}

extension Character {
    func toVO() -> CharacterVO {
        return CharacterVO(id: id, name: name, role: role, image_url: image_url, imageData: imageData, nicknames: nicknames, about: about)
    }
}
