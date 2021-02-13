import ArgumentParser
import Foundation

/// A command that searches for translations for a term in a language.
struct Search: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Search for translations for a term.")
    
    /// A text matching type
    enum Match: String, ExpressibleByArgument {
        /// Match exact matches
        case exact
        /// Match terms that contain the text
        case contains
        /// Match terms that contain each word in the text
        case containsAll
    }
    
    /// The language to find translations in.
    @Option(name: .shortAndLong, help: "The language to find translations in.")
    var language: String
    
    /// The text matching type, defaults to `contains`.
    @Option(name: .shortAndLong, help: "The text matching type, defaults to `contains`.")
    var match: Match = .contains
    
    /// The text to find.
    @Argument(help: "The text to find.")
    var text: String
    
    /// Runs the command
    /// - Throws: When there is an error in glossary parsing
    func run() throws {
        print("􀅴  Reading Glossaries...")
        let parser = Parser()
        
        let entries = try parser.parse(language: language)
        print("􀅴  Found \(entries.count) localization entries!")
        
        let keyedEntries = Dictionary(grouping: entries, by: \.base)
        print("􀅴  Found \(keyedEntries.count) unique strings!")
        
        let options = keyedEntries
            .filter { entry in
                switch match {
                case .exact: return entry.key.lowercased() == text
                case .contains: return entry.key.lowercased().contains(text.lowercased())
                case .containsAll:
                    let textWords = text.split(separator: " ")
                    return entry.key.split(separator: " ").allSatisfy { textWords.contains($0) }
                }
            }
            .flatMap(\.value)
        print("􀅴  Found \(options.count) strings matching or containing `\(text)`!")
        
        if options.isEmpty {
            print("􀇾  Failed to find any translations containing \(text).", color: .red)
            return
        }
        
        print("")
        for option in options {
            print("􀅶   \(option.base)", color: .cyan)
            print("􀰑   \(option.translation)", color: .green)
            if let comment = option.comment {
                print("􀌪  \(comment)", color: .magenta)
            }
            print("􀟕   \(option.key)", color: .white)
            print("􀎫   \(option.fileURL.lastPathComponent)", color: .white)
            print("")
        }
    }
}
