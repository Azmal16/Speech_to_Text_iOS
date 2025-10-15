import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: SpeechViewModel

    init(viewModel: SpeechViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            if viewModel.isSurveyCompleted {
                // Survey Completed View
                Spacer()
                Text("You have answered all the questions!")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action: {
                    withAnimation {
                        viewModel.restartSurvey()
                    }
                }) {
                    Text("Start Again")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()
            } else {
                // Current Question View
                Text("Question \(viewModel.survey.currentIndex + 1)")
                    .font(.title)
                    .padding()

                Text(viewModel.currentQuestion.text)
                    .font(.headline)
                    .padding()

                List(viewModel.currentQuestion.options, id: \.self) { option in
                    HStack {
                        Text(option)
                            .padding(.vertical, 8)
                        Spacer()
                        if viewModel.selectedOption == option {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .transition(.scale)
                        }
                    }
                }
                .animation(.default, value: viewModel.selectedOption)

                Text("Answer: \(viewModel.answer)")
                    .padding()

                Spacer()

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
        }
        .padding()
    }
}
