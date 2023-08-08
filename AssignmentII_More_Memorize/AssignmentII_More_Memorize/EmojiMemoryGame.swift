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
        let numPairs = theme.numPairsToShow ?? Int.random(in: 3...emojis.count)
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
    
    func getGradient() -> Gradient {
        var colorList: [Color] = []
        for color in currTheme.colors {
            switch color {
            case "red":
                colorList.append(Color.red)
            case "orange":
                colorList.append(Color.orange)
            case "yello":
                colorList.append(Color.yellow)
            case "green":
                colorList.append(Color.green)
            case "blue":
                colorList.append(Color.blue)
            case "purple":
                colorList.append(Color.purple)
            case "pink":
                colorList.append(Color.pink)
            case "brown":
                colorList.append(Color.brown)
            default:
                colorList.append(Color.gray)
            }
        }
        return Gradient(colors: colorList)
    }
    
    func getScore() -> Int {
        model.score
    }
    
    func restart() {
        currTheme = themeList.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(currTheme)
    }
}
