//
//  Local.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 3/10/23.
//

import Foundation

protocol Local{
    
    func getItemsList() async throws -> [CharacterVO]
    func getItemByID(id: Int64) async throws -> CharacterVO?
    
}
