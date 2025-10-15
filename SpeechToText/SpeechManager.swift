import Speech
import Foundation

class SpeechManager: ObservableObject {
    private var speechRecognizer = SFSpeechRecognizer()
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audioEngine = AVAudioEngine()
    
    private var inputNode: AVAudioInputNode?
    private var silenceTimer: Timer?  // Timer to detect silence
    
    @Published var recognizedText = ""
    @Published var isRecording = false
    var completion: ((String) -> Void)?
    
    var currentQuestion: Question?
    var moveToNextQuestion: (() -> Void)?
    
    private let silenceTimeout: TimeInterval = 1.0 // 2 seconds after silence

    func reset() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionTask?.finish()
            inputNode?.removeTap(onBus: 0)
        }
        recognitionTask = nil
        recognizedText = ""
        isRecording = false
        silenceTimer?.invalidate()
        silenceTimer = nil
    }

    func startListening() {
        reset()
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            print("Speech recognizer not available")
            return
        }

        let request = SFSpeechAudioBufferRecognitionRequest()
        inputNode = audioEngine.inputNode
        request.shouldReportPartialResults = true

        recognitionTask = recognizer.recognitionTask(with: request) { result, error in
            if let result = result {
                DispatchQueue.main.async {
                    self.recognizedText = result.bestTranscription.formattedString
                    self.resetSilenceTimer()
                }
            }
            if error != nil {
                self.stopListening()
                self.compareAnswer()
            }
        }

        // Start audio capture
        let recordingFormat = inputNode?.outputFormat(forBus: 0)
        inputNode?.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }

        audioEngine.prepare()
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try self.audioEngine.start()
                DispatchQueue.main.async { self.isRecording = true }
            } catch {
                print("Audio engine start failed: \(error)")
            }
        }
    }

    // Silence timer resets every time new speech is detected
    private func resetSilenceTimer() {
        silenceTimer?.invalidate()
        silenceTimer = Timer.scheduledTimer(withTimeInterval: silenceTimeout, repeats: false) { _ in
            self.stopListening()
            self.compareAnswer()
        }
    }

    func stopListening() {
        silenceTimer?.invalidate()
        silenceTimer = nil
        
        if let inputNode = inputNode {
            inputNode.removeTap(onBus: 0)
        }
        
        audioEngine.stop()
        recognitionTask?.finish()
        DispatchQueue.main.async { self.isRecording = false }
    }

    func compareAnswer() {
        guard let currentQuestion = currentQuestion else { return }
        let options = currentQuestion.options
        for option in options {
            if recognizedText.lowercased().contains(option.lowercased()) {
                completion?(option)
                moveToNextQuestion?()
                return
            }
        }
        completion?("No match found")
    }
}
