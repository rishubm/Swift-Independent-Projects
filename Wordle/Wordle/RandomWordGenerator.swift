//
//  RandomWordGenerator.swift
//  Wordle
//
//  Created by Madhav, Rishub P on 3/20/23.
//

import Foundation
struct RandomWordGenerator {
    private var words: [String]
    
    init()
    {
        words = [""]
        initWords()
    }
    
    mutating func initWords()
    {
        if let startWordsPath = Bundle.main.path(forResource: "dictionary", ofType: "txt")
        {
            if let startWords = try? String(contentsOfFile: startWordsPath)
            {
                words = startWords.components(separatedBy: "\n").filter{$0.count == 5}
            }
                    
        }
        else
        {
            print("here")
            words = [""]
        }
    }
   
    func next() -> String
    {
        return (words.randomElement()!)
    }
    

}
