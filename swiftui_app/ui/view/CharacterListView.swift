//
//  ContentView.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 14/9/23.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel : CharacterListViewModel
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    init(viewModel: CharacterListViewModel = CharacterListViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        if viewModel.baseState.isLoading{
            ProgressView()
                .scaleEffect(2)
                .onAppear {
                    viewModel.loadData()
                }
        } else {
            
            NavigationStack{
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.baseState.characterList.sorted(by: { $0.role == "Main" && $1.role != "Main" }), id: \.id) { character in
                            NavigationLink(value: character) {
                                CharacterCellView(character: character)
                            }
                        }
                    }
                    .padding()
                }
                .background(Color("BackgroundList"))
                .listStyle(PlainListStyle())
                .navigationTitle("Characters")
                .toolbar{
                    Button(action: {
                        viewModel.baseState.isLoading = true
                            }) {
                                Image(systemName: "arrow.counterclockwise.circle.fill")
                                    .foregroundColor(Color.black) // Cambia el color del icono a negro
                                    .background(Color.white) // Establece el fondo en blanco
                                    .cornerRadius(15)

                                
                            }
                }
                .toolbarBackground(Color("ToolbarColor"), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationDestination(for: Character.self) { character in
                    CharacterDetailView(character: character)
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCharacters = [
            Character(id: "5627", name: "Brook", role: "Main", image_url: "https://cdn.myanimelist.net/images/characters/10/161005.jpg?s=8e3191d4d9691fffe3dafaefaf086014", imageData: UIImage(named: "brookImage")?.jpegData(compressionQuality: 1.0)),
            Character(id: "64", name: "Franky", role: "Main", image_url: "https://cdn.myanimelist.net/images/characters/13/210053.jpg?s=58f71be3af78384ac43869b8c681efaf", imageData: UIImage(named: "brookImage")?.jpegData(compressionQuality: 1.0)),
            Character(id: "18938", name: "Jinbe", role: "Main", image_url: "https://cdn.myanimelist.net/images/characters/15/307148.jpg?s=20f8bf1d3a9854be84b67367849b1322", imageData: UIImage(named: "brookImage")?.jpegData(compressionQuality: 1.0)),
            Character(id: "40", name: "Monkey D., Luffy", role: "Main", image_url: "https://cdn.myanimelist.net/images/characters/9/310307.jpg?s=3a27ab33bee665febfba970f24f203ba", imageData: UIImage(named: "brookImage")?.jpegData(compressionQuality: 1.0)),
            Character(id: "723", name: "Nami", role: "Main", image_url: "https://cdn.myanimelist.net/images/characters/2/263249.jpg?s=e6c7015918ec37d6b31d680f8944790c", imageData: UIImage(named: "brookImage")?.jpegData(compressionQuality: 1.0)),
            Character(id: "61", name: "Nico, Robin", role: "Main", image_url: "https://cdn.myanimelist.net/images/characters/13/136773.jpg?s=d3e32396042cafb9680a0d5223c4b018", imageData: UIImage(named: "brookImage")?.jpegData(compressionQuality: 1.0)),
            Character(id: "62", name: "Roronoa, Zoro", role: "Main", image_url: "https://cdn.myanimelist.net/images/characters/3/100534.jpg?s=4a00840eacc26e9ad86bae6f505e4826", imageData: UIImage(named: "brookImage")?.jpegData(compressionQuality: 1.0)),
            Character(id: "305", name: "Sanji", role: "Main", image_url: "https://cdn.myanimelist.net/images/characters/5/136769.jpg?s=52b8fdfc38114a389d83dd5301842556", imageData: UIImage(named: "brookImage")?.jpegData(compressionQuality: 1.0)),
            Character(id: "309", name: "Tony Tony, Chopper", role: "Main", image_url:"https://cdn.myanimelist.net/images/characters/3/100536.jpg?s=9536cd3e6fe65064a110b8d8b2f2808e" ,imageData:UIImage(named:"brookImage")?.jpegData(compressionQuality :1.0)),
            Character(id :"724",name:"Usopp" ,role:"Main" ,image_url:"https://cdn.myanimelist.net/images/characters/16/188076.jpg?s=f24eccad7d76e7747895a9a945d8a3ed" ,imageData:UIImage(named:"brookImage")?.jpegData(compressionQuality :1.0)),
            Character(id :"161858",name:"A.O" ,role:"Supporting" ,image_url:"https://cdn.myanimelist.net/images/characters/12/369203.jpg?s=efd534c1758e8333daf0f319a37ff091" ,imageData:UIImage(named:"brookImage")?.jpegData(compressionQuality :1.0)),
            Character(id :"108589",name:"Abdullah" ,role:"Supporting" ,image_url:"https://cdn.myanimelist.net/images/characters/8/250459.jpg?s=a07765798861c812cbe1af27264c6532" ,imageData:UIImage(named:"brookImage")?.jpegData(compressionQuality :1.0)),
            Character(id :"9655",name:"Absalom" ,role:"Supporting" ,image_url:"https://cdn.myanimelist.net/images/characters/9/50244.jpg?s=349596ff734729b55d732d454314e8be" ,imageData:UIImage(named:"brookImage")?.jpegData(compressionQuality :1.0)),
            Character(id :"154437",name:"Acilia" ,role:"Supporting" ,image_url:"https://cdn.myanimelist.net/images/characters/8/357397.jpg?s=c864f114dc28966621318e842620eeff" ,imageData:UIImage(named:"brookImage")?.jpegData(compressionQuality :1.0)),
            Character(id :"23533",name:"Agotogi" ,role:"Supporting" ,image_url:"https://cdn.myanimelist.net/images/characters/13/56874.jpg?s=30af0ad676db81cd9d5ea9520227fec1" ,imageData:UIImage(named:"brookImage")?.jpegData(compressionQuality :1.0))
        ]
        let sampleViewModel = CharacterListViewModel()
        sampleViewModel.baseState.characterList = sampleCharacters
        sampleViewModel.baseState.isLoading = false
        
        return CharacterListView(viewModel: sampleViewModel)
    }
}



