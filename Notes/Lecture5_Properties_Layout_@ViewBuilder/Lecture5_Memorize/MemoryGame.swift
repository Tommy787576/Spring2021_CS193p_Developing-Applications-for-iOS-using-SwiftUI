//
//  MemoryGame.swift
//  Memorize
//
//  Created by 林士平 on 2023/4/7.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // we save same info in two places
    // we can compute indexOfTheOneAndOnlyFaceUpCard from cards
    // make both in the sync
    private(set) var cards: Array<Card>
    
    // make lots of codes into two lines and more readable
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        // we can even make two lines into one line
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
//            let faceUpCardIndices = cards.indices.filter({ cards[$0].isFaceUp })
            // change to functional programming
//            var faceUpCardIndices = [Int]()
//            for index in cards.indices {    // cards.indices == 0..<cards.count
//                if cards[index].isFaceUp {
//                    faceUpCardIndices.append(index)
//                }
//            }
            
//            return faceUpCardIndices.oneAndOnly
            // use extension to add oneAndOnly
//            if faceUpCardIndices.count == 1 {
//                return faceUpCardIndices.first  // .first == [0]
//            }
//            else {
//                return nil
//            }
//        }
        set { cards.indices.forEach{ cards[$0].isFaceUp = ($0 == newValue) } }
//            for index in cards.indices {
//                cards[index].isFaceUp = (index == newValue)
//                // newValue will be the chosenIndex!
//                if index != newValue {
//                    cards[index].isFaceUp = false
//                }
//                else {
//                    cards[index].isFaceUp = true
//                }
//            }
//        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }

    struct Card: Identifiable {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}

// option + click Array => see Array<Element>: Element means don't care in array
extension Array {
    // var in extension: computed
    var oneAndOnly: Element? {
//        if self.count == 1 {
//            return self.first
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
