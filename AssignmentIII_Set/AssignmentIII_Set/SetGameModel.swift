//
//  SetGame.swift
//  AssignmentIII_Set
//
//  Created by 林士平 on 2023/8/3.
//

import Foundation

struct SetGameModel {
    private var deck: Array<Card>           // cards not displaying on the screen
    private(set) var cards: Array<Card>     // cards displaying on the screen
    private var chosenIndices: Array<Int>   // set of indices currently selected
    private var matchedState: Int           // 0: Set Game!, 1: Unmatched!, 2: Matched!
    
    init () {
        deck = []
        cards = []
        chosenIndices = []
        matchedState = 0
        var idx = 0
        for count in Count.allCases {
            for form in Form.allCases {
                for shading in Shading.allCases {
                    for color in ShapeColor.allCases {
                        deck.append(Card(count: count, form: form, shading: shading, color: color, id: idx))
                        idx += 1
                    }
                }
            }
        }
        deck.shuffle()
        let deckSz = deck.count
        for idx in 0..<12 { // there are 12 cards on the screen initially
            cards.append(deck[deckSz - 1 - idx])
        }
        deck.removeLast(12)
    }
    
    mutating func updateStates(_ chosenIndices: Array<Int>, _ currState: Int) {
        for idx in chosenIndices {
            cards[idx].state = currState
        }
    }

    mutating func choose(_ card: Card) {
        if var chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if cards[chosenIndex].isChosen && (matchedState != 1) {
                // deselect can only be done when there's only 1-2 cards is selected
                // or 3 cards unmatched and any cards is selected
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
                    // 3 cards is selected then checking is matched or not
                    if checkIsSet() {
                        matchedState = 2
                        updateStates(chosenIndices, 2)
                    }
                    else {
                        matchedState = 1
                        updateStates(chosenIndices, 1)
                    }
                }
                else if chosenIndices.count == 4 {
                    // 3 cards is selected and any cards is selected
                    updateStates(chosenIndices, 0)
                    if matchedState == 2 {  // 3 cards is matched
                        if !deckIsEmpty() {
                            // deck is not empty: replace matched cards with new cards from deck
                            let deckSz = deck.count
                            for idx in 0..<3 {
                                cards[chosenIndices[idx]] = deck[deckSz - 1 - idx]
                            }
                            deck.removeLast(3)
                        }
                        else {
                            // deck is empty: remove matched cards from cards array
                            // should remove from largest to smallest indices!
                            for idx in chosenIndices[0..<3].sorted(by: >) {
                                cards.remove(at: idx)
                            }
                            // update the chosenIndex
                            if let newChosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
                                chosenIndex = newChosenIndex
                            }
                            chosenIndices[3] = chosenIndex
                        }
                    }
                    else {  // 3 cards is unmatched
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
    
    // check selected cards form a set or not
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
    
    // check if three cards have all different values or all same values
    func checkIsMatch<T: Equatable>(_ val: T, _ val2: T, _ val3: T) -> Bool {
        if val == val2 && val2 == val3 {
            return true
        }
        if val != val2 && val2 != val3 && val3 != val {
            return true
        }
        return false
    }
    
    mutating func dealThreeMoreCards() {
        let deckSz = deck.count
        if matchedState == 2 {
            // replace the selected cards if the selected cards make a Set
            for idx in 0..<3 {
                cards[chosenIndices[idx]] = deck[deckSz - 1 - idx]
            }
            chosenIndices.removeFirst(3)
            matchedState = 0
        }
        else {
            // add 3 new cards to join the ones already on screen
            for idx in 0..<3 {
                cards.append(deck[deckSz - 1 - idx])
            }
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
        var state = 0
        let count: Count
        let form: Form
        let shading: Shading
        let color: ShapeColor
        let id: Int
    }
}

