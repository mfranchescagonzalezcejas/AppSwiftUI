//
//  CharacterCellView.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 21/9/23.
//

import SwiftUI


struct CharacterCellView: View {
    let character: Character
    var body: some View {
        
        HStack(alignment: .center) {
            if let data = character.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                    .cornerRadius(10)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.white, lineWidth: 5)
                    )
                    .shadow(radius: 5)
                    .padding(.trailing)

                
            }
            VStack(alignment: .leading) {
                Text(character.name).font(.title)
                Text(character.role).font(.headline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct CharacterCellView_Previews: PreviewProvider {
    static var previews: some View {
        let brook = Character(id: 5627, name: "Brook", role: "Main", image_url: "https://cdn.myanimelist.net/images/characters/10/161005.jpg?s=8e3191d4d9691fffe3dafaefaf086014", imageData: UIImage(named: "brookImage")?.jpegData(compressionQuality: 1.0))
        CharacterCellView(character: brook)
    }
}
