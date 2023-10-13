//
//  CharacterViewModel.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 2/10/23.
//

import Foundation

open class CharacterListViewModel: NSObject, ObservableObject {
    @Published private var repository: RepositoryImpl = RepositoryImpl()
    @Published var baseState = BaseState()
    private var coroutinesUtils = CoroutinesUtils()
    
    func loadData() {
        var characters: [Character] = []
        coroutinesUtils.runBG { [self] in
            do {
                characters = try await repository.getItemsList()
            } catch {
                print("Error al cargar los datos")
            }
            coroutinesUtils.runMain { [self] in
                baseState.characterList = characters
                baseState.isLoading = false
            }
        }
    }
}
