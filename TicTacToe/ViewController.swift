//
//  ViewController.swift
//  TicTacToe
//
//  Created by Madhav, Rishub P on 9/22/22.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet var buttons: [UIButton]!
    var board : [Int] = [0,0,0,0,0,0,0,0,0]
    @IBOutlet var playerTurn: UILabel!
    @IBOutlet var AIMode: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerTurn.text = "Player 1"
        for button in buttons
        {
            button.setTitle("", for: UIControl.State.normal)
            button.addTarget(self, action: #selector(turn), for: .touchUpInside)
            
        }
        
        // Do any additional setup after loading the view.
        
    }
    func switchTurn()
    {
        if AIMode.isOn && playerTurn.text == "Player 1"
        {
            playerTurn.text = "Computer"
        }
        else if playerTurn.text == "Player 1"
        {
            playerTurn.text = "Player 2"
        }
        else{
            playerTurn.text = "Player 1"
        }
    }
    @objc func turn(_ sender: UIButton)
    {
        if board[sender.tag] != 0
        {
            return
        }
        if !AIMode.isOn && playerTurn.text == "Player 1"
        {
            sender.setTitle("X", for: UIControl.State.normal)
            sender.setTitleColor(UIColor.red, for: UIControl.State.normal)
            board[sender.tag] = 1
        }
        if !AIMode.isOn && playerTurn.text == "Player 2"{
            sender.setTitle("O", for: UIControl.State.normal)
            sender.setTitleColor(UIColor.blue, for: UIControl.State.normal)
            board[sender.tag] = 2
        }
        if AIMode.isOn && playerTurn.text == "Player 1"
        {
            sender.setTitle("X", for: UIControl.State.normal)
            sender.setTitleColor(UIColor.red, for: UIControl.State.normal)
            board[sender.tag] = 1
            playerTurn.text = "Computer"
            if checkWin()
            {
                return
            }
            _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(aiMove), userInfo: nil, repeats: false)
        }
        
       if checkWin()
        {
           return
        }
        
        if(!board.contains(0))
        {
            playerTurn.text = "Draw!"
            _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(restartGame), userInfo: nil, repeats: false)
            return
        }
        
        if !AIMode.isOn {switchTurn()}
    }
    @objc func restartGame()
    {
        
        board = [0,0,0,0,0,0,0,0,0]
        for button in buttons
        {
            button.setTitle("", for: UIControl.State.normal)
        }
        print("HERE")
        playerTurn.text = "Player 1"
        
    }
    func checkWin() -> Bool
    {
        if win().0{
            print(win().1)
            playerTurn.text = (win().1)
            _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(restartGame), userInfo: nil, repeats: false)
            return true
        }
        return false
    }
    @IBAction func toggleAI(_ sender: UISwitch) {
        restartGame()
    }
    func win() -> (Bool, String)
    {
        var i : Int = 0
        while i < 3
        {
            
            if i == 0  && board[i] != 0
            {
                if board[i] == board[4] && board[i] == board[8]
                {
        
                    return (true, board[i] == 1 ? "Player 1 Wins!" : "Player 2 Wins!")
                }
                if board[i] == board[i+2] && board[i] == board[i+1]
                {
                    return (true, board[i] == 1 ? "Player 1 Wins!" : "Player 2 Wins!")
                }
            }
            if i == 2
            {
                if board[i] == board[4] && board[i] == board[6] && board[i] != 0
                {
                    return (true, board[i] == 1 ? "Player 1 Wins!" : "Player 2 Wins!")
                }
            }
            if board[i] == board[i+3] && board[i] == board[i+6] && board[i] != 0
            {
                return (true, board[i] == 1 ? "Player 1 Wins!" : "Player 2 Wins!")
            }
            i += 1
        }
        var j : Int = 3
        while j <= 6
        {
            if board[j] == board[j+1] && board[j] == board[j+2] && board[j] != 0
            {
                return (true, board[j] == 1 ? "Player 1 Wins!" : "Player 2 Wins!")
            }
            j+=3
        }
        return (false, "no winner yet")
    }
    
    @objc func aiMove()
    {
        playerTurn.text = "Player 1"
        while true
        {
            let rand = Int.random(in: 0...8)
            if board[rand] == 0
            {
                print(board)
                board[rand] = 2
                var sender : UIButton = buttons[rand]
                for button in buttons
                {
                    if button.tag == rand
                    {
                        sender = button
                        break
                    }
                }
                sender.setTitle("O", for: UIControl.State.normal)
                sender.setTitleColor(UIColor.blue, for: UIControl.State.normal)
                break
            }
            if(!board.contains(0))
            {
                return
            }
        }
        if(win().0 && win().1 != "Player 1 Wins!")
        {
            playerTurn.text = "Computer Wins!"
            _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(restartGame), userInfo: nil, repeats: false)
            return
        }
           
    }


}

