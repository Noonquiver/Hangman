//
//  ViewController.swift
//  Hangman
//
//  Created by Camilo Hernández Guerrero on 29/06/22.
//

import UIKit

class ViewController: UIViewController {
    var gameWords = [String]()
    var alphabet = [UIButton]()
    var alphabetView: UIView!
    var hiddenAnswer = [UILabel]()
    var answer = ""
    var hangman = [UIImageView]()
    var scoreLabel: UILabel!
    var trophy: UIImageView!
    var attempts = 0
    var lettersGuessed = 0
    var wordsGuessed = 0 {
        didSet {
            scoreLabel.text = "Words guessed: \(wordsGuessed)"
        }
    }
    
    enum AlertAction {
        case gamePassed
        case lost
        case levelPassed
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "color")!)
        
        loadWords()
        
        var counter = 0
        
        let hangmanView = UIImageView()
        hangmanView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hangmanView)
        
        alphabetView = UIView()
        alphabetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alphabetView)
        
        for index in 0..<10 {
            let letterLabel = UILabel()
            letterLabel.translatesAutoresizingMaskIntoConstraints = false
            letterLabel.font = UIFont.systemFont(ofSize: 50)
            letterLabel.textAlignment = .center
            letterLabel.text = "_"
            view.addSubview(letterLabel)
            hiddenAnswer.append(letterLabel)
            
            if index >= answer.count {
                letterLabel.isHidden = true
            }
        
            letterLabel.bottomAnchor.constraint(equalTo: alphabetView.topAnchor, constant: -20).isActive = true
            letterLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: CGFloat(counter * 35)).isActive = true

            counter += 1
        }
        
        let hangman1 = UIImageView(image: UIImage(named: "hangman1"))
        hangman1.translatesAutoresizingMaskIntoConstraints = false
        hangman1.isHidden = true
        hangmanView.addSubview(hangman1)
        hangman.append(hangman1)
        
        let hangman2 = UIImageView(image: UIImage(named: "hangman2"))
        hangman2.translatesAutoresizingMaskIntoConstraints = false
        hangman2.isHidden = true
        hangmanView.addSubview(hangman2)
        hangman.append(hangman2)
        
        let hangman3 = UIImageView(image: UIImage(named: "hangman3"))
        hangman3.translatesAutoresizingMaskIntoConstraints = false
        hangman3.isHidden = true
        hangmanView.addSubview(hangman3)
        hangman.append(hangman3)
        
        let hangman4 = UIImageView(image: UIImage(named: "hangman4"))
        hangman4.translatesAutoresizingMaskIntoConstraints = false
        hangman4.isHidden = true
        hangmanView.addSubview(hangman4)
        hangman.append(hangman4)
        
        let hangman5 = UIImageView(image: UIImage(named: "hangman5"))
        hangman5.translatesAutoresizingMaskIntoConstraints = false
        hangman5.isHidden = true
        hangmanView.addSubview(hangman5)
        hangman.append(hangman5)
        
        let hangman6 = UIImageView(image: UIImage(named: "hangman6"))
        hangman6.translatesAutoresizingMaskIntoConstraints = false
        hangman6.isHidden = true
        hangmanView.addSubview(hangman6)
        hangman.append(hangman6)
        
        let hangman7 = UIImageView(image: UIImage(named: "hangman7"))
        hangman7.translatesAutoresizingMaskIntoConstraints = false
        hangman7.isHidden = true
        hangmanView.addSubview(hangman7)
        hangman.append(hangman7)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Words guessed: 0"
        view.addSubview(scoreLabel)
        
        trophy = UIImageView(image: UIImage(named: "trophy"))
        trophy.translatesAutoresizingMaskIntoConstraints = false
        trophy.isHidden = true
        view.addSubview(trophy)
        
        let width = 59
        let height = 70
        
        for row in 0..<4 {
            for column in 0..<7 {
                let alphabetButton = UIButton(type: .system)
                alphabetButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
                alphabetButton.setTitle("", for: .normal)
                alphabetButton.frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                alphabetButton.tintColor = .white
                alphabetButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                alphabetView.addSubview(alphabetButton)
                alphabet.append(alphabetButton)
            }
        }
        
        let alphab = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        for (index, letter) in alphab.enumerated() {
            alphabet[index].setTitle(String(letter), for: .normal)
        }
        
        NSLayoutConstraint.activate([
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            hangmanView.widthAnchor.constraint(equalTo: view.widthAnchor),
            hangmanView.heightAnchor.constraint(equalToConstant: 500),
            hangmanView.topAnchor.constraint(equalTo: view.topAnchor),
            alphabetView.widthAnchor.constraint(equalTo: view.widthAnchor),
            alphabetView.heightAnchor.constraint(equalToConstant: 300),
            alphabetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hangman1.bottomAnchor.constraint(equalTo: hangmanView.bottomAnchor, constant: -80),
            hangman1.leadingAnchor.constraint(equalTo: hangmanView.leadingAnchor, constant: 8),
            hangman2.bottomAnchor.constraint(equalTo: hangman1.topAnchor),
            hangman3.leadingAnchor.constraint(equalTo: hangman2.trailingAnchor),
            hangman3.topAnchor.constraint(equalTo: hangman2.topAnchor),
            hangman4.topAnchor.constraint(equalTo: hangman3.bottomAnchor),
            hangman4.centerXAnchor.constraint(equalTo: hangman3.trailingAnchor, constant: -10),
            hangman5.topAnchor.constraint(equalTo: hangman4.bottomAnchor, constant: -10),
            hangman5.centerXAnchor.constraint(equalTo: hangman4.centerXAnchor),
            hangman6.topAnchor.constraint(equalTo: hangman4.bottomAnchor),
            hangman6.centerXAnchor.constraint(equalTo: hangman4.centerXAnchor),
            hangman7.topAnchor.constraint(equalTo: hangman6.bottomAnchor),
            hangman7.centerXAnchor.constraint(equalTo: hangman6.centerXAnchor, constant: -5),
            trophy.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            trophy.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            trophy.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func loadWords() {
        if let wordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let words = try? String(contentsOf: wordsURL) {
                gameWords = words.components(separatedBy: ", ")
            }
        }
        
        for (index, word) in gameWords.enumerated() {
            gameWords[index] = word.replacingOccurrences(of: "\n", with: "")
        }
        
        newWord()
    }
    
    func newWord() {
        if let word = gameWords.randomElement() {
            answer = word
        }
        
        guard let wordIndex = gameWords.firstIndex(of: answer) else { return }
        gameWords.remove(at: wordIndex)
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        var wrongLetter = true
        guard var buttonLetter = sender.titleLabel?.text else { return }
        buttonLetter = buttonLetter.uppercased()
        
        for (index, letter) in answer.enumerated() {
            if letter.uppercased().elementsEqual(buttonLetter) {
                hiddenAnswer[index].text = String(letter.uppercased())
                sender.isHidden = true
                wrongLetter = false
                lettersGuessed += 1
            }
        }
        
        if lettersGuessed == answer.count {
            if gameWords.isEmpty {
                wordsGuessed += 1
                trophy.isHidden = false
                alphabetView.isUserInteractionEnabled = false
                alertHandler(title: "You have passed the game!", message: "There's no more words left.", action: .gamePassed)
            } else {
                wordsGuessed += 1
                alertHandler(title: "Well done!", message: "You have guessed the word, ready for the next one?", action: .levelPassed)
            }
        } else if wrongLetter {
            hangman[attempts].isHidden = false
            attempts += 1
        }
        
        if attempts == 7 {
            alphabetView.isHidden = true
            alertHandler(title: "You lost", message: "There's no more attempts left, you are a hanged man.", action: .lost)
        }
    }
    
   func nextLevel(_ action: UIAlertAction) {
        attempts = 0
        lettersGuessed = 0
        newWord()
        
        for letter in alphabet {
            letter.isHidden = false
        }
        
        for piece in hangman {
            piece.isHidden = true
        }
        
        for index in 0..<10 {
            hiddenAnswer[index].text = "_"
            
            if index < answer.count {
                hiddenAnswer[index].isHidden = false
            } else {
                hiddenAnswer[index].isHidden = true
            }
        }
    }
    
    func alertHandler (title: String, message: String, action: AlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if action == AlertAction.gamePassed {
            alertController.addAction(UIAlertAction(title: "Awesome!", style: .cancel))
        } else if action == AlertAction.lost {
            alertController.addAction(UIAlertAction(title: "Okay :(", style: .cancel))
        } else {
            alertController.addAction(UIAlertAction(title: "Let's do it!", style: .default, handler: nextLevel))
        }
        
        present(alertController, animated: true)
    }
}
