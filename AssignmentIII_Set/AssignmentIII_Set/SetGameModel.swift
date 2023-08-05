//
//  SetGame.swift
//  AssignmentIII_Set
//
//  Created by 林士平 on 2023/8/3.
//

import Foundation

// TODO: change number to enum
// count: 0->one, 1->two, 2->three
// form: 0->diamond, 1->squiggle(rectangle), 2->oval
// shading: 0->solid, 0.4->striped(half transparent), 1.0->open
// color: 0->red, 1->green, 2->purple
struct SetGameModel {
    private var deck: Array<Card>       // cards not displaying on the screen
    private(set) var cards: Array<Card> // cards displaying on the screen
    
    init () {
        deck = []
        cards = []
        var idx = 0
        for count in 0...2 {
            for form in 0...2 {
                for shading in [0, 0.4, 1.0] {
                    for color in 0...2 {
                        deck.append(Card(count: count, form: form, shading: shading, color: color, id: idx))
                        idx += 1
                    }
                }
            }
        }
        deck.shuffle()
        let deckSz = deck.count
        for idx in 0..<12 {
            cards.append(deck[deckSz - 1 - idx])
        }
        deck.removeLast(12)
    }

    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            cards[chosenIndex].isChosen = !cards[chosenIndex].isChosen
        }
    }
    
    mutating func dealThreeMoreCards() {
        let deckSz = deck.count
        for idx in 0..<3 {
            cards.append(deck[deckSz - 1 - idx])
        }
        deck.removeLast(3)
    }
    
    func deckIsEmpty() -> Bool {
        deck.count == 0
    }

    struct Card: Identifiable {
        var isChosen = false
        let count: Int
        let form: Int
        let shading: Double
        let color: Int
        let id: Int
    }
}

