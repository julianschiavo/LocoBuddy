import ArgumentParser

struct LocoBuddy: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A command-line tool to parse and traverse AppleGlot Localization Glossaries",
        subcommands: [Search.self, Translate.self])
    
    init() { }
}

LocoBuddy.main()
