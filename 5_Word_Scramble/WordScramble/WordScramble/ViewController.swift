//
//  ViewController.swift
//  WordScramble
//
//  Created by Kamil Chlebuś on 14/01/2018.
//  Copyright © 2018 Kamil Chlebuś. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWords()
        startGame()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
    }
    
    func loadWords() {
        if let wordsFilePath = Bundle.main.path(forResource: "start", ofType: "txt"),
            let startWords = try? String(contentsOfFile: wordsFilePath) {
                allWords = startWords.components(separatedBy: "\n")
        } else {
            loadDefaultWords()
        }
    }
    
    func loadDefaultWords() {
        allWords = ["silkworm"]
    }
    
    func startGame() {
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        title = allWords[0]
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] _ in
            let answer = ac.textFields![0]
            self.submit(answer: answer.text!)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(answer: String) {
        let lowerAnswer = answer.lowercased()
        if !hasProperLength(word: lowerAnswer) {
            showSubmitError(title: "Word is too short", message: "Word has to have more than 3 characters in length!")
            return
        }
        if !isPossible(word: lowerAnswer) {
            showSubmitError(title: "Word not possible", message: "You can't spell that word from '\(title!.lowercased())'!")
            return
        }
        if !isOriginal(word: lowerAnswer) {
            showSubmitError(title: "Word used already", message: "Be more original!")
            return
        }
        if !isReal(word: lowerAnswer) {
            showSubmitError(title: "Word not recognised", message: "You can't just make them up, you know!")
            return
        }
        usedWords.insert(lowerAnswer, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func showSubmitError(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = title!.lowercased()
        for letter in word {
            if let pos = tempWord.range(of: String(letter)) {
                tempWord.remove(at: pos.lowerBound)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func hasProperLength(word: String) -> Bool {
        if word.count < 4 || word.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

}

