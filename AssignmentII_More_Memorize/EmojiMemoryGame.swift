//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 林士平 on 2023/4/11.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private let themeList: [Theme.Content]
    private var currTheme: Theme.Content
    @Published private var model: MemoryGame<String>
    
    init() {
        themeList = [Theme().vehicle, Theme().animal, Theme().food, Theme().moon, Theme().weather, Theme().sport]
        currTheme = themeList.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(currTheme)
    }

    static func createMemoryGame(_ theme: Theme.Content) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numPairs = theme.numCardsToShow > emojis.count ? emojis.count : theme.numCardsToShow
        return MemoryGame<String>(numberOfPairsOfCards: numPairs) { pairIndex in emojis[pairIndex]
        }
    }

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func getTheme() -> String {
        currTheme.name
    }
    
    func getColor() -> Color {
        switch currTheme.color {
        case "red":
            return Color.red
        case "orange":
            return Color.orange
        case "yello":
            return Color.yellow
        case "green":
            return Color.green
        case "blue":
            return Color.blue
        case "purple":
            return Color.purple
        default:
            return Color.gray
        }
    }
    
    func getScore() -> Int {
        model.score
    }
    
    func restart() {
        currTheme = themeList.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(currTheme)
    }
}
