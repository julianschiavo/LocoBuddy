import Foundation

extension XMLElement {
    func onlyChild(named name: String) -> XMLElement? {
        elements(forName: name).single
    }
}
