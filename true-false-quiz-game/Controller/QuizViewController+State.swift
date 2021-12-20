//
//  QuizViewController+State.swift
//  true-false-quiz-game
//
//  Created by Динара Зиманова on 12/20/21.
//

import UIKit

extension QuizViewController {
  struct State {
    let questions: [Question]
    let numberOfQuestions: Int
    var currentQuestion: Int
    var correctAnswers: Int
    
    init(questions: [Question]) {
      self.questions = questions
      numberOfQuestions = questions.count
      currentQuestion = 1
      correctAnswers = 0
    }
    
    var isLastQuestion: Bool {
      return currentQuestion == numberOfQuestions
    }
    
    var question: Question {
      return questions[currentQuestion - 1]
    }
  }
}

