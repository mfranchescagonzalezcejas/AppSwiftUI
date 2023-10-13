//
//  LocalImpl.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 3/10/23.
//

import Foundation

class LocalImpl: Local{
    
    private var database: Network = NetworkImpl()
    
    func getItemsList() async throws -> [CharacterVO] {
        return try await database.getItemsList()
    }

    func getItemByID(id: String) async throws -> CharacterVO? {
        return try await database.getItemByID(id: id)
    }
}
