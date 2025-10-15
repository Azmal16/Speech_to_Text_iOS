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
    var currentIndex: Int = 0

    init(questions: [Question]) {
        self.questions = questions
    }

    func getCurrentQuestion() -> Question {
        if currentIndex < questions.count {
            return questions[currentIndex]
        } else {
            // Return a placeholder; shouldn't be accessed if survey is completed
            return Question(id: -1, text: "", options: [])
        }
    }

    func moveToNextQuestion() {
        currentIndex += 1
    }

    func reset() {
        currentIndex = 0
    }
}
