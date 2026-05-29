import SwiftUI
import UIKit

struct PDFExportService {
    func makeReport(title: String, sections: [String]) -> URL? {
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 612, height: 792))
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("\(title.replacingOccurrences(of: " ", with: "_")).pdf")

        do {
            try renderer.writePDF(to: url) { context in
                context.beginPage()
                let heading = NSAttributedString(
                    string: title,
                    attributes: [.font: UIFont.boldSystemFont(ofSize: 26), .foregroundColor: UIColor.black]
                )
                heading.draw(at: CGPoint(x: 48, y: 48))

                var y: CGFloat = 96
                for section in sections {
                    let text = NSAttributedString(
                        string: section + "\n\n",
                        attributes: [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.darkGray]
                    )
                    text.draw(in: CGRect(x: 48, y: y, width: 516, height: 120))
                    y += 126
                }
            }
            return url
        } catch {
            return nil
        }
    }
}

