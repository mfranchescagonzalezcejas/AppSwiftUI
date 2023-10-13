//
//  Repository.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 3/10/23.
//

import Foundation

protocol Repository{
    func getItemsList() async throws -> [Character]
    func getItemByID(id: String) async throws -> Character?
    
}
