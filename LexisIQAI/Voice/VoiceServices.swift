import AVFoundation
import Foundation
import Speech
import SwiftUI

@MainActor
final class SpeechRecognitionService: ObservableObject {
    @Published var transcript = ""
    @Published var authorizationStatus = SFSpeechRecognizerAuthorizationStatus.notDetermined

    func requestAuthorization() {
        SFSpeechRecognizer.requestAuthorization { status in
            Task { @MainActor in
                self.authorizationStatus = status
            }
        }
    }

    func appendMockPhrase() {
        transcript += transcript.isEmpty ? "Client instructions received. Key issue concerns termination rights and evidence chronology." : " Further note: verify limitation dates and jurisdiction-specific procedure."
    }
}

@MainActor
final class VoiceRecordingService: ObservableObject {
    @Published var isRecording = false
    @Published var isPaused = false

    func start() {
        isRecording = true
        isPaused = false
    }

    func pauseResume() {
        guard isRecording else { return }
        isPaused.toggle()
    }

    func stop() {
        isRecording = false
        isPaused = false
    }
}

@MainActor
final class WaveformAnimationManager: ObservableObject {
    @Published var levels: [CGFloat] = Array(repeating: 0.18, count: 36)

    func tick(active: Bool) {
        levels = levels.indices.map { index in
            active ? CGFloat.random(in: 0.16...1.0) * (index.isMultiple(of: 3) ? 0.78 : 1.0) : 0.18
        }
    }
}

struct VoicePlaybackPlaceholder {
    var duration: TimeInterval = 0
    var title = "Playback architecture placeholder"
}

