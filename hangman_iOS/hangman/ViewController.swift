//
//  ViewController.swift
//  hangman
//
//  Created by Felice Leighton on 13/11/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet var letterButtons: [UIButton]!

    let maxLives = 7

    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    var currentGame: Game!
    
    func getValidWord(_ listOfWords: [String]) -> String? {
        var newWord: String? = listOfWords.randomElement()
        
        while newWord != nil && (newWord!.contains("-") || newWord!.contains(" ")) {
            newWord = listOfWords.randomElement()
        }
        
        return newWord
    }
    
    func newRound() {
        if let validWord = getValidWord(listOfWords) {
            currentGame = Game(word: validWord, lives: maxLives, guessedLetters: [])
            enableLetterButtons(true)
            updateUi()
        } else {
            // Handle scenario if no valid word is found
            print("No valid word available")
            // You can add further handling for this scenario, like informing the user or ending the game.
        }
    }

/*
func newRound(){
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            let randomIndex = Int.random(in: 0..<listOfWords.count)
            let newWord = listOfWords[randomIndex]
            currentGame = Game(word: newWord, lives: maxLives, guessedLetters: [])
            enableLetterButtons(true)
            updateUi()
        } else {
            enableLetterButtons(false)
        }
        
    } 
*/

    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUi(){
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        //let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = currentGame.formattedWord
        scoreLabel.text = "Wins: \(totalWins), Looses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.lives)")
        
    }
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.titleLabel!.text!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.lives == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUi()
        }
    }
    
}

