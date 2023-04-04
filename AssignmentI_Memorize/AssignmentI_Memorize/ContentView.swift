//
//  ContentView.swift
//  Memorize
//
//  Created by 林士平 on 2023/3/9.
//

import SwiftUI

struct ContentView: View {
    var vehicleEmojis: [String]
    var animalEmojis: [String]
    var foodEmojis: [String]
    @State var emojis: [String]
    
    init() {
        vehicleEmojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍️", "🛺", "🚔", "🚍", "🚘", "🚖", "🚡", "🚃", "🚝", "🚅", "🚂", "✈️", "🚀", "🛸", "🚁", "🛶", "⛵️", "🚉"]
        animalEmojis = ["🐶", "🐱", "🐰", "🐼", "🐯", "🦁", "🐣", "🦆", "🦉", "🐴"]
        foodEmojis = ["🍎", "🫑", "🍗", "🧄", "🥐", "🥨", "🍞", "🥩", "🌭", "🍔", "🍟", "🍕", "🫓", "🥪", "🥙", "🧆", "🌮"]
        emojis = vehicleEmojis
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis, id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }.foregroundColor(.red)
            Spacer()
            HStack {
                Spacer()
                vehicles
                Spacer()
                animals
                Spacer()
                food
                Spacer()
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
//    struct Button&Text: View {
//        var body: some View {
//            VStack {
//                HStack
//            }
//        }
//    }
    
    var vehicles: some View {
        Button {
            emojis = vehicleEmojis
        } label: {
            Image(systemName: "car")
        }
    }
    
    var animals: some View {
        Button {
            emojis = animalEmojis
        } label: {
            Image(systemName: "pawprint")
        }
    }

    var food: some View {
        Button {
            emojis = foodEmojis
        } label: {
            Image(systemName: "fork.knife")
        }
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = true
    var content: String
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}























// Control what the preview works
// Color Scheme: dark / light mode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
