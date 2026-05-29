import Foundation

struct RemoteAIService: AIProviding {
    var endpoint = URL(string: "https://YOUR_BACKEND_URL.com/lexisiq-ai")!

    func run(_ request: AIRequest) async throws -> AIResponse {
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(request)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw AIServiceError.invalidResponse
        }

        let decoded = try JSONDecoder().decode(AIRemoteResponse.self, from: data)
        return AIResponse(
            summary: decoded.summary,
            insights: decoded.insights,
            researchRoadmap: decoded.researchRoadmap,
            riskAnalysis: decoded.riskAnalysis,
            draft: decoded.draft,
            confidence: 0.72,
            jurisdictionNote: "Jurisdiction awareness: verify all generated material against the applicable jurisdiction, court hierarchy, and current law."
        )
    }
}

