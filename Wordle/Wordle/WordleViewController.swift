//
//  ViewController.swift
//  Wordle
//
//  Created by Madhav, Rishub P on 2/27/23.
//
import UIKit
class WordleViewController: UIViewController {
    
    @IBOutlet var dead: UILabel!
    @IBOutlet var labels: [WordleLabel]!
    var game = WordleModel()
    var deadLetters = Set<String>()
    @IBOutlet var textFieldOutlet: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBAction func changeText(_ sender: UITextField) {
        guard let textEntered = sender.text?.uppercased() else
        {
            return
        }
        guard textEntered.count <= 5 else
        {
            return
        }
        let start = 5 * (game.turnNumber-1)
        let arr = Array(textEntered)
        for i in start ... start+5
        {
            labels[i].text = ""
        }
        for i in start ..< start + arr.count
        {
            labels[i].text = String(arr[i-start])
        }
    }
    @IBAction func textField(_ sender: UITextField) {
        guard let textEntered = sender.text else
        {
            return
        }
        guard game.isValidWord(word: textEntered) else
        {
            return
        }
        game.current = textEntered.uppercased()
        sender.text = ""
        let updated = game.compareToAnswer()
        let startIndex = (game.turnNumber-1)*5
        for i in startIndex...startIndex + 4
        {
            labels[i].letter    = updated[(i)-startIndex].letter
            labels[i].colorFlag = updated[(i)-startIndex].colorFlag
            labels[i].flip(letter: labels[(i)-startIndex].letter, colorFlag: labels[i-startIndex].colorFlag)
            if labels[i].colorFlag == 0{
                deadLetters.insert(labels[i].text!)
            }
        }
        dead.text = "Dead Letters: \(String(([String](deadLetters)).sorted().joined(separator: ",")))"
        game.turnNumber += 1
        if game.hasWon || game.turnNumber > 6
        {
            print(game.shareEmojis)
            sendAlert()
        }
        
    }
    @objc func sendAlert()
    {
        let alertTitle = game.hasWon ? "Good job!" : "Game over..."
        let message = game.hasWon ? "You took \(game.turnNumber - 1) turn(s)" : "Out of tries! The word was \(game.answer)"
        let alert = UIAlertController(title: alertTitle, message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Restart", comment: "restart"), style: .default, handler: {action in self.restartGame()}))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Share", comment: "share"), style: .default, handler: {action in self.shareSheet()}))
        
        self.present(alert, animated: true, completion: nil)
    }
    @objc func restartGame()
    {
        print("resetting...")
        for label in labels
        {
            label.colorFlag = 0
            label.letter = ""
            label.updateLetter()
            label.updateColor()
            dead.text = "Dead Letters: "
        }
        game = WordleModel()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else {return}
        if sender.tag == 1
        {
            let vc = segue.destination as! SettingsViewController
            vc.model = game
        }
    }
    @objc func shareSheet()
    {
        let items = [game.shareEmojis]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
        restartGame()
    }
  
    @IBAction func tapBG(_ sender: UITapGestureRecognizer) {
        textFieldOutlet.endEditing(true)
    }
}

