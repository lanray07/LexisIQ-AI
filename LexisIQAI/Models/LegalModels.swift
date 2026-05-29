import Foundation
import SwiftData

@Model
final class LegalProfile {
    var id: UUID
    var profession: String
    var jurisdiction: String
    var practiceArea: String
    var createdAt: Date

    init(profession: String, jurisdiction: String, practiceArea: String) {
        self.id = UUID()
        self.profession = profession
        self.jurisdiction = jurisdiction
        self.practiceArea = practiceArea
        self.createdAt = .now
    }
}

@Model
final class Matter {
    var id: UUID
    var title: String
    var status: String
    var notes: String
    var createdAt: Date

    init(title: String, status: String = "Active", notes: String = "") {
        self.id = UUID()
        self.title = title
        self.status = status
        self.notes = notes
        self.createdAt = .now
    }
}

@Model
final class ResearchProject {
    var id: UUID
    var title: String
    var topic: String
    var summary: String
    var createdAt: Date

    init(title: String, topic: String, summary: String = "") {
        self.id = UUID()
        self.title = title
        self.topic = topic
        self.summary = summary
        self.createdAt = .now
    }
}

@Model
final class LegalDocument {
    var id: UUID
    var fileName: String
    var summary: String
    var createdAt: Date

    init(fileName: String, summary: String = "") {
        self.id = UUID()
        self.fileName = fileName
        self.summary = summary
        self.createdAt = .now
    }
}

@Model
final class VoiceTranscript {
    var id: UUID
    var transcript: String
    var aiSummary: String
    var createdAt: Date

    init(transcript: String, aiSummary: String = "") {
        self.id = UUID()
        self.transcript = transcript
        self.aiSummary = aiSummary
        self.createdAt = .now
    }
}

@Model
final class ContractReview {
    var id: UUID
    var riskScore: Int
    var findings: String
    var createdAt: Date

    init(riskScore: Int, findings: String) {
        self.id = UUID()
        self.riskScore = riskScore
        self.findings = findings
        self.createdAt = .now
    }
}

@Model
final class ChronologyEvent {
    var id: UUID
    var title: String
    var eventDate: Date
    var notes: String
    var createdAt: Date

    init(title: String, eventDate: Date, notes: String = "") {
        self.id = UUID()
        self.title = title
        self.eventDate = eventDate
        self.notes = notes
        self.createdAt = .now
    }
}

@Model
final class KnowledgeGraphNode {
    var id: UUID
    var nodeType: String
    var title: String

    init(nodeType: String, title: String) {
        self.id = UUID()
        self.nodeType = nodeType
        self.title = title
    }
}

@Model
final class SubscriptionState {
    var id: UUID
    var plan: String
    var isActive: Bool
    var renewsAt: Date?

    init(plan: String = "Free", isActive: Bool = false, renewsAt: Date? = nil) {
        self.id = UUID()
        self.plan = plan
        self.isActive = isActive
        self.renewsAt = renewsAt
    }
}

struct AIResponse: Identifiable, Hashable {
    let id = UUID()
    var summary: String
    var insights: [String]
    var researchRoadmap: [String]
    var riskAnalysis: [String]
    var draft: String
    var confidence: Double
    var jurisdictionNote: String

    static let empty = AIResponse(
        summary: "",
        insights: [],
        researchRoadmap: [],
        riskAnalysis: [],
        draft: "",
        confidence: 0,
        jurisdictionNote: ""
    )
}

struct AnalyticsMetric: Identifiable {
    let id = UUID()
    var label: String
    var value: Int
}

