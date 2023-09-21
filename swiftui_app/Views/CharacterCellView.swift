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
        
        VStack{
            Spacer()
            VStack(alignment: .center) {
                Text(character.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(character.role)
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .frame(width: 120)
            .padding(10)
            .background(
                .ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
        }
        .frame(width: 140,height: 200)
        .padding(10)
        .background(
            Group {
                if let data = character.imageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Color.clear
                }
            }
        )
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}



struct CharacterCellView_Previews: PreviewProvider {
    static var previews: some View {
        let brook = Character(id: 5627, name: "Monkey D., Luffy", role: "Main", image_url: "https://cdn.myanimelist.net/images/characters/10/161005.jpg?s=8e3191d4d9691fffe3dafaefaf086014", imageData: UIImage(named: "brookImage")?.jpegData(compressionQuality: 1.0))
        CharacterCellView(character: brook)
    }
}
