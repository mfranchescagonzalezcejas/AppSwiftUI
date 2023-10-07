//
//  RepositoryImpl.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 3/10/23.
//

import Foundation

class RepositoryImpl: Repository {
    private var local: Local = LocalImpl()
    
    func getItemsList() async throws -> [Character] {
        return try await local.getItemsList().map { $0.toModel() }
    }

    func getItemByID(id: Int64) async throws -> Character? {
        if let characterVO = try await local.getItemByID(id: id) {
            return characterVO.toModel()
        } else {
            return nil
        }
    }
}

