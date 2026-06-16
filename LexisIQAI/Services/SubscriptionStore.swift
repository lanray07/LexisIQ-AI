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

    func displayPrice(for productID: String, fallback: String) -> String {
        products.first(where: { $0.id == productID })?.displayPrice ?? fallback
    }

    func restorePurchases() async throws {
        isLoading = true
        defer { isLoading = false }

        try await AppStore.sync()
        await refreshActivePlan()
    }

    func refreshActivePlan() async {
        activePlan = "Free"

        for await verification in Transaction.currentEntitlements {
            guard case .verified(let transaction) = verification,
                  productIDs.contains(transaction.productID) else {
                continue
            }
            activePlan = planName(for: transaction.productID)
        }
    }

    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()
        if case .success(let verification) = result, case .verified(let transaction) = verification {
            activePlan = planName(for: transaction.productID)
            await transaction.finish()
        }
    }

    func purchase(productID: String) async throws -> Bool {
        if products.isEmpty {
            await loadProducts()
        }

        guard let product = products.first(where: { $0.id == productID }) else {
            return false
        }

        try await purchase(product)
        return true
    }

    private func planName(for productID: String) -> String {
        productID.contains("chambers") ? "Chambers" : "Professional"
    }
}
