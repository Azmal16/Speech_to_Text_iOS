import SwiftUI

@main
struct SpeechToTextApp: App {
    var body: some Scene {
        WindowGroup {
            // Initialize SurveyViewModel with the list of questions
            let survey = Survey(questions: [
                // Original questions
                Question(id: 1, text: "How many hours did you sleep last night?", options: ["Seven hours", "Five hours", "Eight hours"]),
                Question(id: 2, text: "How do you feel today?", options: ["Very energetic", "Quite tired", "Stressed"]),
                Question(id: 3, text: "What did you eat for breakfast?", options: ["Cereal", "Scrambled eggs", "Pancakes"]),
                Question(id: 4, text: "How often do you exercise?", options: ["Every day", "Once per week", "Never"]),
                Question(id: 5, text: "How many cups of coffee do you drink daily?", options: ["One cup daily", "Two cups daily", "No coffee today"]),
                
                // New questions with 2–4 words per option
                Question(id: 6, text: "Which type of music do you enjoy most?", options: ["Rock music", "Jazz Music", "Classical music"]),
                Question(id: 7, text: "Which outdoor activity do you prefer?", options: ["Mountain hiking", "Cycling ride", "Gardening"]),
                Question(id: 8, text: "Which cuisine do you like best?", options: ["Italian food", "Mexican dishes", "Thai meals"]),
                Question(id: 9, text: "Which pet do you prefer?", options: ["Friendly pet dog", "Cute house cat", "Colorful singing bird"]),
                Question(id: 10, text: "Which drink do you enjoy most in the evening?", options: ["Green tea", "Brewed coffee", "Herbal infusion"])
            ])
            
            // Pass the ViewModel with the Survey data to ContentView
            ContentView(viewModel: SurveyViewModel(survey: survey))
        }
    }
}
