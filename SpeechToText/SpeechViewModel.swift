//
//  SpeechViewModel.swift
//  SpeechToText
//
//  Created by Azmal Awsaf on 13/10/25.
//


import Foundation

class SpeechViewModel: ObservableObject {
    private var speechManager = SpeechManager()

    @Published var recognizedText = ""
    @Published var isRecording = false

    init() {
        // Observe changes from the SpeechManager
        speechManager.$recognizedText.assign(to: &$recognizedText)
        speechManager.$isRecording.assign(to: &$isRecording)
    }

    func startRecording() {
        speechManager.startListening()
    }

    func stopRecording() {
        speechManager.stopListening()
    }
}
