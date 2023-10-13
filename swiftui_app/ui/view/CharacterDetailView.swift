//
//  CharacterDetailView.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 20/9/23.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject private var viewModel : CharacterDetailViewModel
    
    init(character: Character) {
        _viewModel = StateObject(wrappedValue: CharacterDetailViewModel(baseState: BaseState(currentCharacter: character)))
        
    }
    
    var body: some View {
        
        if viewModel.baseState.isLoading{
            ProgressView()
                .scaleEffect(2)
                .onAppear {
                    viewModel.loadData()
                }
        } else {
            CharacterInfoView(character: viewModel.baseState.currentCharacter)
            
        }
        
    }
}
struct CharacterImageView: View {
    let character: Character
    var body: some View {
        VStack {
            if let data = character.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)//afecta imagen interior
                    .padding(5) // Ajusta la cantidad de espacio para el borde exterior
                    .background(Color("BorderCell")) // Cambia el color del borde exterior según tus preferencias
                    .cornerRadius(20)//afeta border exterior
            }
        }
        .frame(width: 140,height: 200)
        .padding(20)
        
    }
}



struct CharacterInfoView: View {
    let character: Character?
    
    var body: some View {
        let opacity = 0.3
        
        
        VStack(alignment: .leading){
            
            HStack {
                CharacterImageView(character: character!)
                VStack(alignment: .leading){
                    Text("Name: \(character?.name ?? "")")
                        .font(.title)
                        .foregroundColor(Color("TextColor"))
                    Text("Role: \(character?.role ?? "")")
                        .font(.subheadline)
                        .foregroundColor(Color("TextColor"))
                    
                    if let nicknames = character?.nicknames {
                        Text("Nicknames:")
                            .font(.headline)
                            .foregroundColor(Color("TextColor"))
                        ForEach(nicknames, id: \.self) { nickname in
                            Text(nickname)
                                .font(.body)
                                .foregroundColor(Color("TextColor"))
                        }
                    }
                }.padding(8)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .opacity(opacity)
                    }
                
            }
            
            
            if let about = character?.about {
                ScrollView {
                    Text("About:\n\(about)")
                        .font(.body)
                        .foregroundColor(Color("TextColor"))
                }
                .padding(8)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .opacity(opacity)
                }
            }
        }
        .padding()
        .background{
            if let character = character, let data = character.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 10)
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(1.2) // Aquí es donde se amplía la imagen
                
            }
        }
    }
    
}




struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let brook = Character(
            id: "5627",
            name: "Brook",
            role: "Musician, Swordsman",
            image_url: "https://cdn.myanimelist.net/images/characters/10/161005.jpg",
            imageData: UIImage(named: "brookImage")?.jpegData(compressionQuality: 1.0),
            nicknames: ["Dead Bones", "Soul King"],
            about: "Age: 88; 90\nBirthdate: April 3; Aries\nHeight: 2m 66cm (8'8½\")\nAffiliation: Straw Hat Pirates (previously; Rumbar Pirates)\nPosition: Musician, Swordsman\nDevil Fruit: Yomi Yomi no Mi (Revive Revive Fruit)\nType: Paramecia\nBounty: \n\nBrook known as the \"Gentleman Skeleton\", is a pirate inhabiting the Florian Triangle region of the Grand Line. Although he claims to be a gentleman, and talks in the dialect of one, Brook's etiquette has severely degenerated over the course of his isolation. He has awful table manners: he shouts for food while waiting to be served, asks to swap plates with people who have larger servings than he does and eating so messily his entire face is stained. He is also extremely flatulent after meals, but says \"excuse me\" so as to be \"gentlemanly.\" He also loves to tell odd, bone-themed jokes, as well as melodramatic tales, and is very perverted, asking to see Nami and Robin's underwear upon meeting them. \n\nHe's a skilled musician (something Luffy has always wanted in his crew since the beginning), fond of playing the violin. Due to his light weight he can not only jump to incredible heights but can run on water by moving his legs furiously. He uses a shikomizue as his main weapon; with it, he is able to make swift iaidō attacks that the enemy cannot notice."
        )
        
        
        return CharacterInfoView(character: brook)
    }
}
