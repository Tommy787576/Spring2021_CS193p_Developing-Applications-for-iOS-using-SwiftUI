//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 林士平 on 2023/3/9.
//

import SwiftUI

// Usually, most var in View should be private
// if we want to rename ContentView
// => option + click -> quick look of the documentation
// => cmd + click -> rename
struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(game.cards) { card in
//                        CardView(card).aspectRatio(2/3, contentMode: .fit)
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }.foregroundColor(.red)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
//    private let card: EmojiMemoryGame.Card
//
//    init (_ card: EmojiMemoryGame.Card) {
//        self.card = card
//    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                // we want to collect all magic numbers
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.linewidth)
//                    Text(card.content).font(.largeTitle)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                    Text(" ").font(.largeTitle)
                } else {
                    shape.fill()
                    Text(" ").font(.largeTitle)
                }
            }
        })
//        ZStack {
//            let shape = RoundedRectangle(cornerRadius: 20.0)
//            if card.isFaceUp {
//                shape.fill().foregroundColor(.white)
//                shape.strokeBorder(lineWidth: 3)
//                Text(card.content).font(.largeTitle)
//            } else if card.isMatched {
//                shape.opacity(0)
//                Text(" ").font(.largeTitle)
//            } else {
//                shape.fill()
//                Text(" ").font(.largeTitle)
//            }
//        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let linewidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}























// Control what the preview works
// Color Scheme: dark / light mode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
