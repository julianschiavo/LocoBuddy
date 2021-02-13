import Foundation

extension XMLNode {
    var textOfOnlyChild: String? {
        guard let onlyChild = children?.single,
              onlyChild.kind == .text
        else {
            return nil
        }
        return onlyChild.stringValue
    }
}
