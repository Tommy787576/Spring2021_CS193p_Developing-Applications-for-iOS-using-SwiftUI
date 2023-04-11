//
//  ContentView.swift
//  Memorize
//
//  Created by 林士平 on 2023/3/9.
//

// click the pin on canvas: it can fix on the page!

import SwiftUI

struct ContentView: View {
    // Part3 of MVVM: detect the published change
    @ObservedObject var viewModel: EmojiMemoryGame
    
    // var body: give me a UI that shows me what's in the model
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    // remove id: \.self -> we want card itself identifiable
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)  // asking viewmodel to express user intent
                            }
                    }
                }
            }.foregroundColor(.red)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle) // Font.largeTitle -> type inference
            } else if card.isMatched {
                shape.opacity(0)    // if it's match then making it opacity -> still ocupy a space
                Text(" ").font(.largeTitle)
            } else {
                shape.fill()
                Text(" ").font(.largeTitle)
            }
        }
    }
}























// Control what the preview works
// Color Scheme: dark / light mode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
