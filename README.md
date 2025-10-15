# Speech-to-Text Survey App

## Overview
This is a simple iOS app that allows users to answer survey questions using their voice. The app listens to the user's speech, converts it to text in real-time, and automatically selects the matching answer from the options. After answering all questions, a completion message is shown, with the ability to restart the survey.

## Features
- Voice recognition for survey answers.
- Automatic detection and selection of the matching option.
- Tick mark appears next to the selected option.
- Automatic progression to the next question.
- Completion message displayed after all questions.
- Restart the survey with a "Start Again" button.

## Libraries / Frameworks Used
- **SwiftUI**: For building the user interface.
- **AVFoundation**: To access the device microphone.
- **Speech**: Apple's Speech framework for speech-to-text recognition.

## Requirements
- iOS 15.0+  
- Xcode 14+  

## Usage
1. Launch the app.
2. Tap the **Speak** button to start recording.
3. Speak your answer clearly; the app will recognize it and select the matching option automatically.
4. Proceed through all questions automatically.
5. Once all questions are answered, tap **Start Again** to restart the survey.
