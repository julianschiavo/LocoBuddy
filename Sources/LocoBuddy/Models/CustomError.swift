import Foundation

struct CustomError: LocalizedError {
    let errorDescription: String?
    
    init(_ errorDescription: String) {
        self.errorDescription = errorDescription
    }
}
