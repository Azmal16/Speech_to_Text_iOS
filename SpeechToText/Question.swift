//
//  Question.swift
//  SpeechToText
//
//  Created by Azmal Awsaf on 14/10/25.
//


import Foundation

// Question model with options
struct Question {
    var id: Int
    var text: String
    var options: [String]
}

// Survey model holding multiple questions
class Survey {
    var questions: [Question]
    var currentIndex = 0
    
    init(questions: [Question]) {
        self.questions = questions
    }
    
    func getCurrentQuestion() -> Question {
        return questions[currentIndex]
    }
    
    func moveToNextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
        }
    }
}
