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
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in cardView(for: card)})
            .foregroundColor(.gray)
            .padding(.horizontal)
    }
    
    @ViewBuilder
    private func cardView(for card: SetGameViewModel.Card) -> some View {
        CardView(card: card)
            .padding(4)
            .onTapGesture {
                game.choose(card)
            }
    }
}

struct CardView: View {
    var card: SetGameViewModel.Card
    let symbols: Symbols = Symbols()
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill().foregroundColor(card.isChosen ? Color.gray.opacity(0.3) : .white)
                shape.strokeBorder(lineWidth: DrawingConstants.linewidth)
                symbols.get(width: geometry.size.width, height: geometry.size.height, count: 3, form: 2, shading: 1, color: 1)
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
        return SetGameView(game: game)
    }
}
