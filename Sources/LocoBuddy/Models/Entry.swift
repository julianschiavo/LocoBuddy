import Foundation

struct Entry {
    /// The file the entry was read from.
    let fileURL: URL
    /// The usage description for the entry.
    let comment: String?
    /// The key identifying this string. This can be <NO KEY> because some Apple strings files use just whitespace as a key and `NSXMLDocument` cannot read whitespace-only text elements.
    let key: String
    /// The original text.
    let base: String
    /// The localised text.
    let translation: String
    /// The language of the translated term.
    let language: String
}
