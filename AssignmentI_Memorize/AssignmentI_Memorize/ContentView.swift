//
//  ContentView.swift
//  Memorize
//
//  Created by 林士平 on 2023/4/4.
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
    
    var vehicles: some View {
        VStack {
            Button {
                let random = Int.random(in: 4...vehicleEmojis.count)
                emojis = Array(vehicleEmojis.shuffled()[0..<random])
            } label: {
                Image(systemName: "car")
            }
            Text("Vehicles").font(.footnote).foregroundColor(Color.blue)
        }
    }
    
    var animals: some View {
        VStack {
            Button {
                let random = Int.random(in: 4...animalEmojis.count)
                emojis = Array(animalEmojis.shuffled()[0..<random])
            } label: {
                Image(systemName: "pawprint")
            }
            Text("Animals").font(.footnote).foregroundColor(Color.blue)
        }
    }

    var food: some View {
        VStack {
            Button {
                let random = Int.random(in: 4...foodEmojis.count)
                emojis = Array(foodEmojis.shuffled()[0..<random])
            } label: {
                Image(systemName: "takeoutbag.and.cup.and.straw")
            }
            Text("Food").font(.footnote).foregroundColor(Color.blue)
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


























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
