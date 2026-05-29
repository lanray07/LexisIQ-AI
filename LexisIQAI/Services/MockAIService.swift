import Foundation

struct MockAIService: AIProviding {
    func run(_ request: AIRequest) async throws -> AIResponse {
        try await Task.sleep(nanoseconds: 450_000_000)
        let topic = request.query.isEmpty ? request.documentText.prefix(80) : Substring(request.query)
        let jurisdiction = request.jurisdiction.isEmpty ? "selected jurisdiction" : request.jurisdiction

        return AIResponse(
            summary: "Mock analysis for \(topic). This output organizes the legal issue, likely authorities, factual assumptions, and recommended next research steps for \(jurisdiction).",
            insights: [
                "Check primary authority before relying on any generated proposition.",
                "Separate binding authority from persuasive commentary and secondary sources.",
                "Map disputed facts to evidence, limitation dates, and procedural posture."
            ],
            researchRoadmap: [
                "Confirm governing jurisdiction and applicable court hierarchy.",
                "Search legislation, rules, and leading cases using narrow issue terms.",
                "Validate currency, treatment history, and any pending reforms.",
                "Prepare a lawyer-reviewed note with citations and risk qualifications."
            ],
            riskAnalysis: [
                "AI confidence is indicative only and may miss jurisdiction-specific nuance.",
                "Professional review is required before client use or filing.",
                "No legal outcome, advice, or representation is guaranteed."
            ],
            draft: "Preliminary work product: identify the issue, summarize the facts, state the governing rule, analyze application, and list open verification points. Lawyer review required.",
            confidence: 0.78,
            jurisdictionNote: "Jurisdiction awareness: verify all authorities against \(jurisdiction) law, court hierarchy, and current procedural rules."
        )
    }
}

