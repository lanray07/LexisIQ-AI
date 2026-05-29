import SwiftData
import SwiftUI

struct VoiceNotesView: View {
    var profile: LegalProfile
    @Environment(\.appServices) private var services
    @Environment(\.modelContext) private var modelContext
    @StateObject private var speech = SpeechRecognitionService()
    @StateObject private var recorder = VoiceRecordingService()
    @StateObject private var waveform = WaveformAnimationManager()
    @StateObject private var viewModel = AIWorkflowViewModel()

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Voice Intelligence")
                        .font(.system(.largeTitle, design: .serif, weight: .bold))
                        .foregroundStyle(.white)
                    Text("Dictate legal notes, meetings, hearings, research ideas, argument strategy, and consultation summaries.")
                        .font(.subheadline)
                        .foregroundStyle(LexisTheme.ink)

                    PremiumPanel {
                        VStack(spacing: 16) {
                            VoiceWaveformView(levels: waveform.levels)
                            HStack {
                                Button {
                                    recorder.isRecording ? recorder.stop() : recorder.start()
                                } label: {
                                    Label(recorder.isRecording ? "Stop" : "Record", systemImage: recorder.isRecording ? "stop.fill" : "mic.fill")
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(recorder.isRecording ? LexisTheme.red : LexisTheme.gold)

                                Button {
                                    recorder.pauseResume()
                                } label: {
                                    Label(recorder.isPaused ? "Resume" : "Pause", systemImage: recorder.isPaused ? "play.fill" : "pause.fill")
                                }
                                .buttonStyle(.bordered)
                                .disabled(!recorder.isRecording)

                                Button {
                                    speech.appendMockPhrase()
                                } label: {
                                    Label("Mock STT", systemImage: "text.badge.plus")
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }

                    PremiumPanel {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Live Transcription").font(.headline)
                            TextEditor(text: $speech.transcript)
                                .frame(minHeight: 180)
                                .scrollContentBackground(.hidden)
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 8).fill(.black.opacity(0.25)))
                            Button {
                                Task {
                                    await viewModel.run {
                                        let result = try await services.voice.process(transcript: speech.transcript, jurisdiction: profile.jurisdiction, practiceArea: profile.practiceArea)
                                        modelContext.insert(VoiceTranscript(transcript: speech.transcript, aiSummary: result.summary))
                                        return result
                                    }
                                }
                            } label: {
                                Label("Generate AI Summary", systemImage: "sparkles").frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(LexisTheme.gold)
                            .foregroundStyle(.black)
                        }
                        .foregroundStyle(.white)
                    }

                    if viewModel.isLoading { LoadingPanel() }
                    if !viewModel.response.summary.isEmpty { AIResponsePanel(response: viewModel.response) }
                    DisclaimerBlock()
                }
                .padding(18)
            }
        }
        .onAppear { speech.requestAuthorization() }
        .onReceive(Timer.publish(every: 0.18, on: .main, in: .common).autoconnect()) { _ in
            waveform.tick(active: recorder.isRecording && !recorder.isPaused)
        }
    }
}

