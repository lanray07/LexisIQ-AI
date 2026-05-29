import Foundation
import StoreKit

@MainActor
final class SubscriptionStore: ObservableObject {
    static let professionalMonthly = "lexisiq.professional.monthly"
    static let professionalYearly = "lexisiq.professional.yearly"
    static let chambersMonthly = "lexisiq.chambers.monthly"

    @Published var products: [Product] = []
    @Published var activePlan = "Free"
    @Published var isLoading = false

    var productIDs: [String] {
        [Self.professionalMonthly, Self.professionalYearly, Self.chambersMonthly]
    }

    func loadProducts() async {
        isLoading = true
        defer { isLoading = false }
        do {
            products = try await Product.products(for: productIDs)
        } catch {
            products = []
        }
    }

    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()
        if case .success(let verification) = result, case .verified(let transaction) = verification {
            activePlan = transaction.productID.contains("chambers") ? "Chambers" : "Professional"
            await transaction.finish()
        }
    }
}

