//
//  MemoryGame.swift
//  Memorize
//
//  Created by 林士平 on 2023/4/7.
//

import Foundation

// where CardContent: Equatable
// -> next week content to make content can use ==
struct MemoryGame<CardContent>  where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    // calling this function is going to change this struct
    mutating func choose(_ card: Card) {
        // all arguments are constant!
        // we want to find card in cards
        // card.isFaceUp = !card.isFaceUp
        // let chosenIndex = index(of: card)!    // we don't want to crash when card is no find
//        if let chosenIndex = index(of: card) {
//            cards[chosenIndex].isFaceUp.toggle()
//        }
        
//        if let chosenIndex = cards.firstIndex(where: { aCardInTheCardsArray in aCardInTheCardsArray.id == card.id }) {
        // A , B -> will first execute A then B
        // !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched: don't deal with cards already face up or matched if we click it again
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
//                for index in 0..<cards.count {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
        
        // var chosenCard = cards[chosenIndex]  // this will make a copy of cards[chosenIndex]
        // cards[chosenIndex].isFaceUp.toggle()    // optional + click to see the type
        // print("chosenCard = \(chosenCard)")  // \(p) will make p to a string
        print("\(cards)")
        
        // print("hello")  // used to debug only work for simulator
        // Xcode -> Behaviors -> Generate output -> show debugger with Console View
        // then output will appear automatically
    }
    
    // this array is built in in swift array
//    func index(of card: Card) -> Int? { // change Int to Int?
//        for index in 0..<cards.count {
//            if cards[index].id == card.id {
//                return index
//            }
//        }
//        return nil
////        return 0    // bogus! we want to return we couldn't find the card you're looking for
//    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    // Make Card identifiable
    // protocal stubs: what are the vars and functions
    // that necessary to me to say Card is identifiable
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
