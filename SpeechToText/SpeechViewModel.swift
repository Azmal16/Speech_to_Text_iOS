import Foundation
import SwiftUI

class SurveyViewModel: ObservableObject {
    @Published var currentQuestion: Question
    @Published var survey: Survey
    @Published var answer: String = ""
    @Published var isRecording = false
    @Published var selectedOption: String? = nil
    
    private var speechManager: SpeechManager
    
    var isSurveyCompleted: Bool {
        survey.currentIndex >= survey.questions.count
    }
    
    init(survey: Survey) {
        self.survey = survey
        self.currentQuestion = survey.getCurrentQuestion()
        self.speechManager = SpeechManager()
        
        self.speechManager.currentQuestion = self.currentQuestion
        
        self.speechManager.completion = { answer in
            DispatchQueue.main.async {
                self.answer = answer
                if self.currentQuestion.options.contains(answer) {
                    self.selectedOption = answer
                }
            }
        }
        
        self.speechManager.moveToNextQuestion = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.easeInOut) {
                    self.moveToNextQuestion()
                }
            }
        }
    }
    
    func startRecording() {
        speechManager.startListening()
    }
    
    func stopRecording() {
        speechManager.stopListening()
    }
    
    func moveToNextQuestion() {
        survey.moveToNextQuestion()
        if !isSurveyCompleted {
            currentQuestion = survey.getCurrentQuestion()
            speechManager.currentQuestion = currentQuestion
            answer = ""
            selectedOption = nil
            stopRecording()
            isRecording = false
        } else {
            // Stop recording when survey ends
            stopRecording()
            isRecording = false
        }
    }
    
    func restartSurvey() {
        survey.currentIndex = 0
        currentQuestion = survey.getCurrentQuestion()
        answer = ""
        selectedOption = nil
        stopRecording()
        isRecording = false
        speechManager.currentQuestion = currentQuestion
    }
}
