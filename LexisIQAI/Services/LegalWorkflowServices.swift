import Foundation

struct LegalResearchService {
    var ai: AIProviding

    func research(query: String, jurisdiction: String, practiceArea: String) async throws -> AIResponse {
        try await ai.run(AIRequest(module: "legal_research", jurisdiction: jurisdiction, practiceArea: practiceArea, query: query, voiceTranscript: "", documentText: ""))
    }
}

struct ContractAnalysisService {
    var ai: AIProviding

    func analyze(contractText: String, jurisdiction: String, practiceArea: String) async throws -> AIResponse {
        try await ai.run(AIRequest(module: "contract_analysis", jurisdiction: jurisdiction, practiceArea: practiceArea, query: "Analyze contract cautiously", voiceTranscript: "", documentText: contractText))
    }
}

struct VoiceAnalysisService {
    var ai: AIProviding

    func process(transcript: String, jurisdiction: String, practiceArea: String) async throws -> AIResponse {
        try await ai.run(AIRequest(module: "voice_notes", jurisdiction: jurisdiction, practiceArea: practiceArea, query: "Summarize voice note into legal productivity outputs", voiceTranscript: transcript, documentText: ""))
    }
}

struct LitigationStrategyService {
    var ai: AIProviding

    func build(facts: String, jurisdiction: String, practiceArea: String) async throws -> AIResponse {
        try await ai.run(AIRequest(module: "litigation_strategy", jurisdiction: jurisdiction, practiceArea: practiceArea, query: facts, voiceTranscript: "", documentText: ""))
    }
}

struct DraftingAssistantService {
    var ai: AIProviding

    func draft(kind: String, input: String, jurisdiction: String, practiceArea: String) async throws -> AIResponse {
        try await ai.run(AIRequest(module: "drafting_assistant_\(kind)", jurisdiction: jurisdiction, practiceArea: practiceArea, query: input, voiceTranscript: "", documentText: ""))
    }
}

struct KnowledgeGraphService {
    func starterNodes() -> [GraphDisplayNode] {
        [
            GraphDisplayNode(type: "Case", title: "Lead authority", x: 0.20, y: 0.32),
            GraphDisplayNode(type: "Statute", title: "Governing statute", x: 0.63, y: 0.24),
            GraphDisplayNode(type: "Principle", title: "Core principle", x: 0.48, y: 0.58),
            GraphDisplayNode(type: "Matter", title: "Active matter", x: 0.25, y: 0.76),
            GraphDisplayNode(type: "Regulation", title: "Regulatory layer", x: 0.78, y: 0.72)
        ]
    }
}

struct AppServices {
    var mockAIEnabled = true
    var provider: AIProviding {
        if mockAIEnabled {
            return MockAIService()
        } else {
            return RemoteAIService()
        }
    }

    var legalResearch: LegalResearchService { LegalResearchService(ai: provider) }
    var contracts: ContractAnalysisService { ContractAnalysisService(ai: provider) }
    var voice: VoiceAnalysisService { VoiceAnalysisService(ai: provider) }
    var litigation: LitigationStrategyService { LitigationStrategyService(ai: provider) }
    var drafting: DraftingAssistantService { DraftingAssistantService(ai: provider) }
    var graph: KnowledgeGraphService { KnowledgeGraphService() }
}

let lexisIQSystemPrompt = """
You are LexisIQ AI, a legal research and productivity assistant. Help legal professionals organize research, summarize information, analyze documents, and prepare legal work products. Do not provide legal advice, legal representation, guarantees of legal outcomes, or unauthorized practice of law.
"""
