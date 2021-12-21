//
//  Question.swift
//  true-false-quiz-game
//
//  Created by Динара Зиманова on 12/20/21.
//

import UIKit

struct Question {
  let title: String
  let isTrue: Bool
}

let questions = [
  ("People may sneeze or cough while sleeping deeply.", false),
  ("Electrons move faster than the speed of light.", false),
  ("The Mona Liza was stolen from the Louvre in 1911.", true),
  ("Light travels in a straight line.", true),
  ("The Big Apple is a nickname given to Washington D.C in 1971.", false),
  
  ("All introverts are shy and socially anxious.", false),
  ("The percentage of students in the US who have taken loans to get through college is declining. ", false),
  
  ("A credit card and a debit card are the same.", false),
  
  ("Ethereum is the second-largest cryptocurrency after Bitcoin.", true),
  ("Women usually reach the earning-peak of their career when they are younger than men.", true),
  
  ("The Atlantic Ocean is the warmest in the world.", false),
  ("When the Eiffel Tower was unveiled, the Parisian art community hated it.", true),
  ("There are more ancient pyramids in Sudan than in Egypt.", true),
  ("The Great Wall of China is visible from space.", false),
  ("There are three rivers in Saudi Arabia.", false)
].map(Question.init)

