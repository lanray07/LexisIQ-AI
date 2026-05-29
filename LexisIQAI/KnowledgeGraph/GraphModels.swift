import Foundation

struct GraphDisplayNode: Identifiable, Hashable {
    let id = UUID()
    var type: String
    var title: String
    var x: Double
    var y: Double
}

