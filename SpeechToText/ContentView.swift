import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: SurveyViewModel

    init(viewModel: SurveyViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            // Question Display
            Text("Question \(viewModel.survey.currentIndex + 1)")
                .font(.title)
                .padding()

            Text(viewModel.currentQuestion.text)
                .font(.headline)
                .padding()

            // Display Options with tick mark for selected answer
            List(viewModel.currentQuestion.options, id: \.self) { option in
                HStack {
                    Text(option)
                        .padding(.vertical, 8)
                    Spacer()
                    if viewModel.selectedOption == option {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .transition(.scale) // Animate appearance
                    }
                }
            }
            .animation(.default, value: viewModel.selectedOption)

            // Display the recognized answer
            Text("Answer: \(viewModel.answer)")
                .padding()

            Spacer()

            // Start/Stop recording button
            Button(action: {
                viewModel.isRecording.toggle()
                if viewModel.isRecording {
                    viewModel.startRecording()
                } else {
                    viewModel.stopRecording()
                }
            }) {
                Text(viewModel.isRecording ? "Stop" : "Speak")
                    .font(.title)
                    .padding()
                    .background(viewModel.isRecording ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}
