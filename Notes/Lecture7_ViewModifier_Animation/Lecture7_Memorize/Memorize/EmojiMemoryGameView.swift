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
//        VStack {
//            ScrollView {
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
//                    ForEach(game.cards) { card in
//                        CardView(card).aspectRatio(2/3, contentMode: .fit)
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in cardView(for: card)})
        .foregroundColor(.red)
        .padding(.horizontal)
//                }
//            }.foregroundColor(.red)
//        }
    }
    
    // place 1: @ViewBuilder at func
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
            //                .aspectRatio(2/3, contentMode: .fit)
                .onTapGesture {
                    game.choose(card)
                }
        }
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
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 200-90))
                    .padding(5)
                    .opacity(0.5)
                // Text is actually not animatable -> font is not animatable !!!
                // Animation only animate changes !!!
                // We can only animate the content on screen !!!
                // When does Text come on screen -> ZStack -> cardify -> isFaceUp change
                // problem: isFaceUp and isMatched change simultaneously
                
                // order: isMatched change -> first card start to animate
                // but second still not on screen until Cardify content is executed
                // so there's no animate on second card
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))  // implicit animation
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
//                    .font(font(in: geometry.size))    // font modififier varing the size of font make it un-animatable
            }
//            Circle().padding().opacity(0.3) // anything can be cardified
//            .modifier(Cardify(isFaceUp: card.isFaceUp))
            .cardify(isFaceUp: card.isFaceUp)
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
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.65
        static let fontSize: CGFloat = 32
    }
}























// Control what the preview works
// Color Scheme: dark / light mode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        // make game choose first card defaultly
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.dark)
//        EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.light)
    }
}
