//
//  SpeechManager.swift
//  SpeechToText
//
//  Created by Azmal Awsaf on 13/10/25.
//


import Foundation
import Speech

class SpeechManager: ObservableObject {
    private var speechRecognizer = SFSpeechRecognizer()
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audioEngine = AVAudioEngine()

    @Published var recognizedText = ""
    @Published var isRecording = false

    func startListening() {
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            print("Speech recognizer is not available.")
            return
        }

        let request = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode

        // Request to recognize audio input
        request.shouldReportPartialResults = true
        
        recognitionTask = recognizer.recognitionTask(with: request) { result, error in
            if let result = result {
                self.recognizedText = result.bestTranscription.formattedString
            }
            if error != nil || result?.isFinal == true {
                self.stopListening()
            }
        }

        // Start the audio engine to capture microphone input
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            request.append(buffer)
        }

        audioEngine.prepare()
        do {
            try audioEngine.start()
            isRecording = true
        } catch {
            print("Audio Engine couldn't start.")
        }
    }

    func stopListening() {
        audioEngine.stop()
        recognitionTask?.finish()
        isRecording = false
    }
}
