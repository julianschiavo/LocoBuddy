import ArgumentParser
import Foundation

/// A command to translate a term into another language, using a key obtained from the `search` command.
struct Translate: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Translate a term into another language, using a key obtained from the `search` command.")
    
    /// The languages to translate the term to.
    @Argument(help: "The languages to translate the term to.")
    var languages: [String]
    
    /// The key for the entry.
    @Option(name: .shortAndLong, help: "The key for the entry.")
    var key: String
    
    /// Runs the command
    /// - Throws: When there is an error in glossary parsing
    func run() throws {
        print("􀅴  Reading Glossaries...")
        let parser = Parser()
        
        let entries = try parser.parse(languages: languages)
        print("􀅴  Found \(entries.count) localization entries!")
        
        let keyedEntries = Dictionary(grouping: entries, by: \.key)
        print("􀅴  Found \(keyedEntries.count) unique strings!")
        
        let options = keyedEntries
            .filter {
                $0.key.lowercased() == key.lowercased()
            }
            .flatMap(\.value)
        
        if options.isEmpty {
            print("􀇾  Failed to find any translations for key \(key).", color: .red)
            return
        }
        
        print("")
        print("􀅶   \(options.first?.base ?? key)", color: .cyan)
        for option in options {
            print("􀰑   \(option.translation)", color: .green)
            print("􀎫   \(option.fileURL.lastPathComponent)", color: .white)
            print("􀆪   \(option.language)", color: .white)
            print("")
        }
    }
}
