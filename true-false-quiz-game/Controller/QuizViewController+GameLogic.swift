//
//  QuizViewController+GameLogic.swift
//  true-false-quiz-game
//
//  Created by Динара Зиманова on 12/20/21.
//

import UIKit

extension QuizViewController {
    
    // MARK: - Methods
    func startGame() {
        state = State(questions: questions)
        goToQuestion(at: 1)
    }
    
    func goToQuestion(at position: Int) {
        state.currentQuestion = position
        
        questionLabel.text = state.question.title
        navigationItem.title = "Question \(position)/\(state.numberOfQuestions)"
        
        let progress = Double(position) / Double(state.numberOfQuestions)
        updateProgress(to: progress)
        startCountdown()
    }
    
    func startCountdown() {
        timeProgressLabel.text = "00:10"
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            let currentSeconds = Int((self.timeProgressLabel.text ?? "0").replacingOccurrences(of: ":", with: "")) ?? 1
            
            guard currentSeconds > 1 else {
                timer.invalidate()
                self.goToNextQuestion()
                return
            }
            
            self.timeProgressLabel.text = "00:0\(currentSeconds - 1)"
        }
    }
    
    func goToNextQuestion() {
        guard !state.isLastQuestion else {
            
            let alert = UIAlertController(title: "Good job!",
                                          message: "You got \(state.correctAnswers) out of \(state.numberOfQuestions) right.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Start Over",
                                          style: .default,
                                          handler: { [weak self] _ in self?.startGame() }))
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        goToQuestion(at: state.currentQuestion + 1)
    }
    
    func showMessage(isCorrect: Bool) {
        messageLabel.text = isCorrect ? "That's correct!\n👍🎉😄" : "Sorry, that's wrong!\n\n👎☠️😢"
        messageLabel.textColor = isCorrect ? .green : .red
        messageLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        messageLabel.alpha = 0
        timer?.invalidate()
        
        UIView.animate(withDuration: 0.7,
                       delay: 0.0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseIn,
                       animations: {
            self.messageLabel.alpha = 1
            self.messageLabel.transform = .identity
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.15,
                           delay: 0.35,
                           animations: {
                self.messageLabel.alpha = 0
            },
                           completion: { _ in
                self.goToNextQuestion()
            })
        })
    }
    
    @objc func handleAnswer(_ sender: UIButton) {
        let userSelection = sender == trueButton
        let isCorrect = state.question.isTrue == userSelection
        
        if isCorrect {
            state.correctAnswers += 1
        }
        
        showMessage(isCorrect: isCorrect)
    }
}
