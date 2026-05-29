import Foundation

@MainActor
final class AIWorkflowViewModel: ObservableObject {
    @Published var query = ""
    @Published var response = AIResponse.empty
    @Published var isLoading = false
    @Published var errorMessage: String?

    func run(_ operation: @escaping () async throws -> AIResponse) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            response = try await operation()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

