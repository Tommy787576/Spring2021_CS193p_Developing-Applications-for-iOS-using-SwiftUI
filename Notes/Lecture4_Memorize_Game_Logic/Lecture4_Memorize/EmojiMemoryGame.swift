//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 林士平 on 2023/4/7.
//

import SwiftUI

// Part1 of MVVM: ObservableObject: to make view detect the change of model!!!!!
class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍️", "🛺", "🚔", "🚍", "🚘", "🚖", "🚡"]

    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 3) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // Part2 of MVVM
    // swift is able to detect the change in struct
    @Published private var model: MemoryGame<String> = createMemoryGame()

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
//    var objectWillChange: ObservableObjectPublisher   // we don't need this -> use @Published
    
    // - is the book mark
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
//        objectWillChange.send() // we want to let anyone know sth is changed  // we don't need this either -> use @Published
        model.choose(card)
    }
}
