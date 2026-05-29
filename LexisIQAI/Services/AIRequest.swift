import Foundation

struct AIRequest: Codable {
    var module: String
    var jurisdiction: String
    var practiceArea: String
    var query: String
    var voiceTranscript: String
    var documentText: String
}

struct AIRemoteResponse: Codable {
    var summary: String
    var insights: [String]
    var researchRoadmap: [String]
    var riskAnalysis: [String]
    var draft: String
}

protocol AIProviding {
    func run(_ request: AIRequest) async throws -> AIResponse
}

enum AIServiceError: LocalizedError {
    case invalidResponse

    var errorDescription: String? {
        "LexisIQ AI could not process the request. Please try again."
    }
}

