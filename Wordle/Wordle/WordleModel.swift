//
//  WordleModel.swift
//  Wordle
//
//  Created by Madhav, Rishub P on 2/27/23.
//

import Foundation
import UIKit

class WordleModel
{
    var answer = ""
    var current = ""
    var turnNumber = 1
    var hasWon = false
    var hints  = [String]()
    var shareEmojis = ""
    var hardModeOn = false

   
    init(){
        let rand = RandomWordGenerator()
        self.answer = rand.next()
        self.current = ""
        print("Answer \(answer)")
    }
    
    public func isReal(word: String) -> Bool { //checks dict
            let checker         = UITextChecker()
            let range           = NSRange(location: 0, length: word.utf16.count)
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            
            return misspelledRange.location == NSNotFound
        
    }
    
    public func isValidWord(word: String) -> Bool
    {
    
        let upper = word.uppercased()
        for char in upper
        {
            if char < "A" || char > "Z" {
                return false
            }
        }
        guard upper.count == 5
        else {
            return false
        }
        
        guard isReal(word: upper.lowercased()) else
        {
            print("\(upper) is not a real word")
            return false
        }
        
        guard hardModeValidate(word: upper) else
        {
            print("Hard mode is on -- user must use all hints from previous guesses")
            return false
        }
        
        return true
    }
    func hardModeValidate(word : String) -> Bool
    {
    
        if hardModeOn && turnNumber != 1
        {
            for letter in hints
            {
                if !word.contains(letter) //if guess does not contain previously guessed hints
                {
                    return false
                }
            }
        }
        return true
    }
    func compareToAnswer() -> [WordleLabel]
    {
        print(current)
        var labels : [WordleLabel] = []
        var answers = Array(answer)
        var letters = Array(current)
      
    
        for char in current
        {
            let label = WordleLabel()
            label.letter = String(char)
            if answers.firstIndex(of: char)  == letters.firstIndex(of: char) //check for greens
            {
                label.colorFlag = 2
                hints.append(label.letter)
                answers[answers.firstIndex(of: char)!] = "0"
                letters[letters.firstIndex(of: char)!] = "0"
                
            }
            labels.append(label)
        }
        if letters == answers
        {
            hasWon = true
            addEmojis(labels: labels)
            return labels
        }
        
        
        for label in labels {
            for letter in answers
            {
                if String(letter) == label.letter && label.colorFlag != 2 //check for yellows
                {
                    label.colorFlag = 1
                    hints.append(label.letter)
                    answers[answers.firstIndex(of: label.letter.first!)!] = "0"
                }
            }
//            if answers.contains(label.letter) && label.colorFlag != 2 //check for yellows
//            {
//
//            }
        }
        addEmojis(labels: labels)
        return labels
    }
    func addEmojis(labels : [WordleLabel])
    {
        for label in  labels
        {
            if label.colorFlag == 0
            {
                shareEmojis.append("⬛")
            }
            
            if label.colorFlag == 1
            {
                shareEmojis.append("🟨")
            }
            
            if label.colorFlag == 2
            {
                shareEmojis.append("🟩")
            }
        }
        shareEmojis.append("\n")
    }

    
}
