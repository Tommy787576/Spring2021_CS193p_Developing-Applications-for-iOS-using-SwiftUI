//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 林士平 on 2023/4/7.
//

// ViewModel is a part of UI
import SwiftUI

//func makeCardContent(index: Int) -> String {
//    return "😀"
//

//let emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍️", "🛺", "🚔", "🚍", "🚘", "🚖", "🚡"]

// The only class: ViewModel -> gate-keeper
class EmojiMemoryGame { // class: all the vars should have initial values
//    var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍️", "🛺", "🚔", "🚍", "🚘", "🚖", "🚡"]
    
    // static: attached to type and only create once when the app start
    static let emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍️", "🛺", "🚔", "🚍", "🚘", "🚖", "🚡"]

    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
//            EmojiMemoryGame.emojis[pairIndex]
            emojis[pairIndex]
        }
    }
    
    // gate-keeper -> private: only the ViewModels' code itself can see the model
    // private(set) -> fully private is a little too restricted
    // -> other classes and structs can look at the model but can't change it
    // private(set) var model: MemoryGame<String>   // emojis: String
    
    // or (card is completelyread-only)
    // private var model: MemoryGame<String> =
    //     MemoryGame<String>(numberOfPairsOfCards: 4, createCardContent: makeCardContent)
//    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    private var model: MemoryGame<String> = createMemoryGame()
//        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
//            // property initializer (assigning value to property with equal sign): property -> var/let
//            // the order of emojis and model are initialized randomly
//            // solution; 1. use init() 2. make emojis global 3. use static: global but called EmojiMemoryGame.emojis
//            emojis[pairIndex]
//        }   // _: doesn't matter
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
