//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Kamil Chlebuś on 13/01/2018.
//  Copyright © 2018 Kamil Chlebuś. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
        loadCountries()
        askQuestion()
    }
    
    func setButtons() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func loadCountries() {
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco",
                      "nigeria", "poland", "russia", "spain", "uk", "us"]
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        shuffleCountries()
        shuffleCorrectAnswer()
        setFlags()
    }
    
    func shuffleCountries() {
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
    }
    
    func setFlags() {
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    func shuffleCorrectAnswer() {
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3) // 0,1,2
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title = ""
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        presentScoreAlert(title: title)
    }
    
    func presentScoreAlert(title: String) {
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
}
