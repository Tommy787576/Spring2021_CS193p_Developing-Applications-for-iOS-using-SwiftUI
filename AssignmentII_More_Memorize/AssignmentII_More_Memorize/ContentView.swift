//
//  ContentView.swift
//  Memorize
//
//  Created by 林士平 on 2023/4/11.
//

// click the pin on canvas: it can fix on the page!

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("\(viewModel.getTheme())!")
                .font(.largeTitle)
                .fontWeight(.bold)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: viewModel.cards.count)))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }.foregroundColor(viewModel.getColor())
            HStack {
                Text("Score: \(viewModel.getScore())")
                Spacer()
                VStack {
                    Button {
                        viewModel.restart()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }.font(.largeTitle)
                    Text("New Game").font(.footnote).foregroundColor(.blue)
                }
            }
        }
        .padding(.horizontal)
    }
    
    func widthThatBestFits(cardCount: Int) -> CGFloat {
        // 12mini: 4 -> 120.0, [5,9] -> 90.0, [10,16] -> 60.0, else 50.0
        if cardCount == 4 {
            return 120.0
        }
        else if cardCount <= 9 {
            return 90.0
        }
        else if cardCount <= 16 {
            return 60.0
        }
        else {
            return 50.0
        }
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
