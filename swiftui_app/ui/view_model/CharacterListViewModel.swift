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
        coroutinesUtils.runBG { [self] in
            do {
                let characters = try await repository.getItemsList()
                coroutinesUtils.runMain { [self] in // runMain
                    baseState.characterList = characters
                    baseState.isLoading = false
                }
            } catch {
                print("Error al cargar los datos")
            }
            //mover aqui el run main
            
        }
    }
}




