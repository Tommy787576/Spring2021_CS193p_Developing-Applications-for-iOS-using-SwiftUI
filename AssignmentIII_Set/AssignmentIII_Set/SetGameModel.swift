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
// color: 0->orange, 1->green, 2->purple
struct SetGameModel {
    private var deck: Array<Card>           // cards not displaying on the screen
    private(set) var cards: Array<Card>     // cards displaying on the screen
    private var chosenIndices: Array<Int>   // set of indices currently selected
    private var matchedState: Int           // 0: blank, 1: unmatched!, 2: matched!
    
    init () {
        deck = []
        cards = []
        chosenIndices = []
        matchedState = 0
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
        if var chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if cards[chosenIndex].isChosen {
                // deselect can only be done when there's only 1-2 cards is selected
                if chosenIndices.count < 3 {
                    if let removeIndex = chosenIndices.firstIndex(of: chosenIndex) {
                        chosenIndices.remove(at: removeIndex)
                    }
                    cards[chosenIndex].isChosen = false
                }
            }
            else {
                chosenIndices.append(chosenIndex)
                if chosenIndices.count == 3 {
                    if checkIsSet() {
                        matchedState = 2
                    }
                    else {
                        matchedState = 1
                    }
                }
                else if chosenIndices.count == 4 {
                    if matchedState == 2 {  // 3 cards matched and the next card is selected
                        if !deckIsEmpty() {
                            let deckSz = deck.count
                            for idx in 0..<3 {
                                print(cards[chosenIndices[idx]].id)
                                cards[chosenIndices[idx]] = deck[deckSz - 1 - idx]
                            }
                            deck.removeLast(3)
                        }
                        else {
                            print(chosenIndices[0..<3].sorted(by: >))
                            for idx in chosenIndices[0..<3].sorted(by: >) {
                                print(cards[idx].id)
                                cards.remove(at: idx)
                            }
                            if let newChosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
                                chosenIndex = newChosenIndex
                            }
                            chosenIndices[3] = chosenIndex
                        }
                    }
                    else {  // 3 cards unmatched and the next card is selected
                        for idx in 0..<3 {
                            cards[chosenIndices[idx]].isChosen = false
                        }
                    }
                    chosenIndices.removeFirst(3)
                    matchedState = 0
                }
                else {
                    matchedState = 0
                }
                cards[chosenIndex].isChosen = true
            }
        }
    }
    
    func checkIsSet() -> Bool {
        let (idx, idx1, idx2) = (chosenIndices[0], chosenIndices[1], chosenIndices[2])
        if (!checkIsMatch(cards[idx].count, cards[idx1].count, cards[idx2].count)) {
            return false
        }
        if (!checkIsMatch(cards[idx].form, cards[idx1].form, cards[idx2].form)) {
            return false
        }
        if (!checkIsMatch(cards[idx].shading, cards[idx1].shading, cards[idx2].shading)) {
            return false
        }
        if (!checkIsMatch(cards[idx].color, cards[idx1].color, cards[idx2].color)) {
            return false
        }
        return true
    }
    
    func checkIsMatch<T: Equatable>(_ val1: T, _ val2: T, _ val3: T) -> Bool {
        if val1 == val2 && val2 == val3 {
            return true
        }
        if val1 != val2 && val2 != val3 && val3 != val1 {
            return true
        }
        return false
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
    
    func getMatchedState() -> Int {
        matchedState
    }

    struct Card: Identifiable, Equatable {
        var isChosen = false
        var isBlank = false
        let count: Int
        let form: Int
        let shading: Double
        let color: Int
        let id: Int
    }
}

