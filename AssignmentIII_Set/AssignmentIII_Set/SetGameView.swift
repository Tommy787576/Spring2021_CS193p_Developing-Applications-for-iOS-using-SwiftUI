//
//  ContentView.swift
//  AssignmentIII_Set
//
//  Created by 林士平 on 2023/7/25.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text(game.matchStatusText()).font(.largeTitle).fontWeight(.bold).foregroundColor(game.matchStatusTextColor())
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in cardView(for: card)})
                .foregroundColor(.gray)
                .padding(.horizontal)
            HStack {
                Spacer()
                VStack {
                    Button {
                        game.restart()
                    } label: {
                        Image(systemName: "gamecontroller")
                    }.font(.largeTitle)
                    Text("New Game").font(.footnote).foregroundColor(.blue)
                }
                Spacer()
                VStack {
                    Button {
                        game.dealThreeMoreCards()
                    } label: {
                        Image(systemName: "square.3.layers.3d")
                    }.font(.largeTitle).disabled(game.deckIsEmpty())
                    Text("Deal Cards").font(.footnote).foregroundColor(game.getDealCardsIconColor())
                }
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func cardView(for card: SetGameViewModel.Card) -> some View {
        CardView(card: card, game: game)
            .padding(4)
            .onTapGesture {
                game.choose(card)
            }
    }
}

struct CardView: View {
    var card: SetGameViewModel.Card
    let symbols: Symbols = Symbols()
    var game: SetGameViewModel
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill().foregroundColor(game.getCardBackgroundColor(card))
                shape.strokeBorder(lineWidth: DrawingConstants.linewidth)
                symbols.get(width: geometry.size.width, height: geometry.size.height, count: card.count, form: card.form, shading: card.shading, color: card.color)
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let linewidth: CGFloat = 1
        static let fontScale: CGFloat = 0.65
        static let cardAspectRatio: CGFloat = 0.6
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game).preferredColorScheme(.light)
    }
}
