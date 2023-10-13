//
//  Database.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 3/10/23.
//

import Foundation

protocol Network {
    func getItemsList() async throws-> [CharacterVO]
    func getItemByID(id: String) async throws -> CharacterVO?
}
