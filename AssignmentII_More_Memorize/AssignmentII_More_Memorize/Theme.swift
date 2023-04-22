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
        emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐"],
        numPairsToShow: nil,    // the number of pairs of cards to show is a random number
        colors: ["red", "orange"]
    )
    var animal = Content(       // default to use all the emoji available in the theme
        name: "animal",
        emojis: ["🐶", "🐱", "🐰", "🐼", "🐯"],
        colors: ["orange", "yello"]
    )
    var food = Content(
        name: "food",
        emojis: ["🍎", "🫑", "🍗", "🧄", "🥐", "🥨", "🍞", "🥩", "🌭", "🍔", "🍟", "🍕", "🫓", "🥪", "🥙", "🧆", "🌮"],
        numPairsToShow: 11,
        colors: ["yello", "green"]
    )
    var moon = Content(
        name: "moon",
        emojis: ["🌕", "🌗", "🌓", "🌜", "🌛", "🌑", "🌙"],
        numPairsToShow: 100,    // A Theme mistakenly specifies to show more pairs of cards than there are emoji available
        colors: ["green", "blue"]
    )
    var weather = Content(
        name: "weather",
        emojis: ["☀️", "⛅️", "☁️", "🌦️", "🌧️", "🌩️", "❄️", "🌬️", "☔️", "🌊"],
        numPairsToShow: nil,    // the number of pairs of cards to show is a random number
        colors: ["blue", "purple"]
    )
    var sport = Content(
        name: "sport",
        emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🥏", "🏓", "🏸", "🏒", "🏑", "🥅", "⛳️"],
        numPairsToShow: 10,
        colors: ["red", "orange", "yello", "green", "blue", "purple"]
    )
    struct Content {
        let name: String
        let emojis: [String]
        let numPairsToShow: Int?
        let colors: [String]
        init(name: String, emojis: [String], numPairsToShow: Int?, colors: [String]) {
            self.name = name
            self.emojis = emojis
            if let temp = numPairsToShow {
                if temp > emojis.count {
                    // Automatically reduce the count of cards to show to match the count of available emoji
                    self.numPairsToShow = emojis.count
                }
                else {
                    self.numPairsToShow = temp
                }
            }
            else {
                self.numPairsToShow = nil
            }
            self.colors = colors
        }
        init(name: String, emojis: [String], colors: [String]) {
            self.name = name
            self.emojis = emojis
            self.numPairsToShow = emojis.count
            self.colors = colors
        }
    }
}
