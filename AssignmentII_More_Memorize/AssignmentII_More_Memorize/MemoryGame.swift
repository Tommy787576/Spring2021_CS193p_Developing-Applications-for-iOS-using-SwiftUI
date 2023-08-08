//
//  MemoryGame.swift
//  Memorize
//
//  Created by 林士平 on 2023/4/7.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int
    private var seenContents: Set<Int>  // save ids of emojis that has been faceup -> facedown
    private var prevChooseDate: Date    // save the time previous click
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        // get number of seconds since last card was chosen
        let interval = Int(Date().timeIntervalSinceReferenceDate - prevChooseDate.timeIntervalSinceReferenceDate)
        let scalingFactor = max(10 - interval, 1)
        prevChooseDate = Date()
        
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += (2 * scalingFactor)  // match
                }
                else {  // mismatch
                    var id = cards[chosenIndex].id
                    if seenContents.contains(id) {  // has already seen
                        score -= (1 * scalingFactor)
                    }
                    id = cards[potentialMatchIndex].id
                    if seenContents.contains(id) {  // has already seen
                        score -= (1 * scalingFactor)
                    }
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    if cards[index].isFaceUp {
                        seenContents.insert(cards[index].id)
                    }
                    cards[index].isFaceUp = false   // turned back to face down
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
        score = 0
        seenContents = []
        prevChooseDate = Date()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int // Identifiable
    }
}