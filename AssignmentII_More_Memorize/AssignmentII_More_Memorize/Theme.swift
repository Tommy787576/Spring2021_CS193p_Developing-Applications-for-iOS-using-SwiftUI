//
//  Theme.swift
//  AssignmentII_More_Memorize
//
//  Created by 林士平 on 2023/4/19.
//

import Foundation

struct Theme {
    var vehicle = Content(
        name: "vehicle",
        emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍️", "🛺", "🚔", "🚍", "🚘", "🚖", "🚡"],
        numCardsToShow: 12,
        color: "red"
    )
    var animal = Content(
        name: "animal",
        emojis: ["🐶", "🐱", "🐰", "🐼", "🐯", "🦁", "🐣", "🦆", "🦉"],
        numCardsToShow: 8,
        color: "orange"
    )
    var food = Content(
        name: "food",
        emojis: ["🍎", "🫑", "🍗", "🧄", "🥐", "🥨", "🍞", "🥩", "🌭", "🍔", "🍟", "🍕", "🫓", "🥪", "🥙", "🧆", "🌮"],
        numCardsToShow: 11,
        color: "yello"
    )
    var moon = Content(
        name: "moon",
        emojis: ["🌕", "🌗", "🌓", "🌜", "🌛", "🌑", "🌙"],
        numCardsToShow: 100,
        color: "green"
    )
    var weather = Content(
        name: "weather",
        emojis: ["☀️", "⛅️", "☁️", "🌦️", "🌧️", "🌩️", "❄️", "🌬️", "☔️", "🌊"],
        numCardsToShow: 9,
        color: "blue"
    )
    var sport = Content(
        name: "sport",
        emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🥏", "🏓", "🏸", "🏒", "🏑", "🥅", "⛳️"],
        numCardsToShow: 10,
        color: "purple"
    )
    struct Content {
        let name: String
        let emojis: [String]
        let numCardsToShow: Int
        let color: String
    }
}
