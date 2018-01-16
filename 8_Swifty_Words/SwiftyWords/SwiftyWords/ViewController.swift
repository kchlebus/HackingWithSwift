//
//  ViewController.swift
//  SwiftyWords
//
//  Created by Kamil Chlebuś on 16/01/2018.
//  Copyright © 2018 Kamil Chlebuś. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    @IBOutlet var cluesLabel: UILabel!
    @IBOutlet var answersLabel: UILabel!
    @IBOutlet var currentAnswerTextField: UITextField!
    @IBOutlet var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
        loadLevel()
    }
    
    func setButtons() {
        for view in view.subviews where view.tag == 1001 {
            let btn = view as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        guard let levelFilePath = Bundle.main.path(forResource: "level1", ofType: "txt"),
            let levelContents = try? String(contentsOfFile: levelFilePath) else {
                return
        }
        
        var lines = levelContents.components(separatedBy: "\n")
        lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
        
        for (index, line) in lines.enumerated() {
            let lineParts = line.split(separator: ":")
            let answer = lineParts[0]
            let clue = lineParts[1]
            
            clueString += "\(index + 1). \(clue)\n"
            
            let solutionWord = answer.replacingOccurrences(of: "|", with: "")
            solutionString += "\(solutionWord.count) letters\n"
            solutions.append(solutionWord)
            
            let bits = answer.components(separatedBy: "|")
            letterBits += bits
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
        if letterBits.count == letterButtons.count { // 20, safety code
            for i in 0..<letterBits.count { // 0-19 invlusive (half-open range operator)
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }

    @IBAction func submitTapped(_ sender: Any) {
        if let solutionPos = solutions.index(of: currentAnswerTextField.text!) {
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text!.components(separatedBy: "\n")
            splitAnswers[solutionPos] = currentAnswerTextField.text!
            answersLabel.text = splitAnswers.joined(separator: "\n")
            
            currentAnswerTextField.text = ""
            score += 1
            
            // Level end
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        }
    }
    
    func levelUp(action: UIAlertAction!) {
        
    }
        
    @IBAction func clearTapped(_ sender: Any) {
        currentAnswerTextField.text = ""
        for btn in activatedButtons {
            btn.isHidden = false
        }
        activatedButtons.removeAll()
    }
    
    @objc func letterTapped(btn: UIButton) {
        currentAnswerTextField.text = currentAnswerTextField.text! + btn.titleLabel!.text!
        activatedButtons.append(btn)
        btn.isHidden = true
    }

}
