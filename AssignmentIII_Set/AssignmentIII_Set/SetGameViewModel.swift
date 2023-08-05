//
//  SetGameViewModel.swift
//  AssignmentIII_Set
//
//  Created by 林士平 on 2023/8/3.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGameModel.Card

    private static func createSetGame() -> SetGameModel {
        SetGameModel()
    }
    
    @Published private var model = createSetGame()

    var cards: Array<Card> {
        model.cards
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func dealThreeMoreCards() {
        model.dealThreeMoreCards()
    }
    
    func deckIsEmpty() -> Bool {
        model.deckIsEmpty()
    }
    
    func restart() {
        model = SetGameViewModel.createSetGame()
    }
}
