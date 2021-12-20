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
//                self.goToNextQuestion()
                return
            }
            
            self.timeProgressLabel.text = "00:0\(currentSeconds - 1)"
        }
    }
}
