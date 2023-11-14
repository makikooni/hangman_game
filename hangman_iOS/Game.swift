//
//  Game.swift
//  hangman
//
//  Created by Felice Leighton on 14/11/2023.
//

import Foundation

struct Game {
    var word: String
    var lives: Int
    var guessedLetters: [Character]
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "-"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            lives -= 1
        }
    }
}
