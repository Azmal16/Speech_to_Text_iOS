import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = SpeechViewModel()

    var body: some View {
        VStack {
            if viewModel.isRecording {
                Text("Listening...")
                    .font(.largeTitle)
                    .foregroundColor(.green)
            } else {
                Text("Tap to start listening")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            }

            Text(viewModel.recognizedText)
                .font(.title)
                .padding()

            Spacer()

            // Button to start or stop recording
            Button(action: {
                if viewModel.isRecording {
                    viewModel.stopRecording()
                } else {
                    viewModel.startRecording()
                }
            }) {
                Text(viewModel.isRecording ? "Stop" : "Start")
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


#Preview {
    ContentView()
}
