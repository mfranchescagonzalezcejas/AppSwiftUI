//
//  CharacterDetailViewModel.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 2/10/23.
//

import Foundation

open class CharacterDetailViewModel: NSObject, ObservableObject {
    @Published var baseState = BaseState()
    @Published private var repository: RepositoryImpl = RepositoryImpl()
    private var coroutinesUtils = CoroutinesUtils()
    
    init(baseState: BaseState) {
        self.baseState = baseState
    }
    func loadData() {
        var characterData: Character = Character(id: "", name: "", role: "", image_url: "")
        coroutinesUtils.runBG { [self] in
            baseState.isLoading = true
            do {
                if let id = baseState.currentCharacter?.id {
                    characterData = try await repository.getItemByID(id: id)!
                }
            } catch {
                print("Error loading data: \(error)")
            }
            coroutinesUtils.runMain { [self] in
                baseState.currentCharacter?.about = characterData.about
                baseState.currentCharacter?.nicknames = characterData.nicknames
                baseState.isLoading = false
            }
        }
    }
}
