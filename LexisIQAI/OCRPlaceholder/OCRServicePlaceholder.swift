import Foundation

struct OCRResult {
    var text: String
    var confidence: Double
}

struct OCRServicePlaceholder {
    func recognizeText(from fileName: String) async -> OCRResult {
        OCRResult(
            text: "OCR placeholder text extracted from \(fileName). Replace with VisionKit, Vision, or server-side OCR.",
            confidence: 0.64
        )
    }
}

