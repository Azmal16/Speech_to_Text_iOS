import Foundation
import SwiftUI

class SurveyViewModel: ObservableObject {
    @Published var currentQuestion: Question
    @Published var survey: Survey
    @Published var answer: String = ""
    @Published var isRecording = false
    @Published var selectedOption: String? = nil // Track the option that was matched
    
    private var speechManager: SpeechManager
    
    init(survey: Survey) {
        self.survey = survey
        self.currentQuestion = survey.getCurrentQuestion()
        self.speechManager = SpeechManager()
        
        self.speechManager.currentQuestion = self.currentQuestion
        
        // Completion called when answer is detected
        self.speechManager.completion = { [weak self] answer in
            DispatchQueue.main.async {
                self?.answer = answer
                // Mark the selected option for tick
                if ((self?.currentQuestion.options.contains(answer)) != nil) {
                    self?.selectedOption = answer
                }
            }
        }
        
        // Automatically move to the next question after a short delay to show the tick
        self.speechManager.moveToNextQuestion = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { // 0.8s to show tick
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
        currentQuestion = survey.getCurrentQuestion()
        speechManager.currentQuestion = currentQuestion
        answer = ""
        selectedOption = nil
        stopRecording()
        isRecording = false
    }
}
