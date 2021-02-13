import Foundation

class Parser {
    
    // MARK: - Public
    
    func parse(language: String) throws -> [Entry] {
        guard let volumes = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: []) else {
            throw CustomError("Failed to mount disk image volumes.")
        }
        
        let languageVolumes = volumes.filter { fileURL -> Bool in
            fileURL.lastPathComponent.contains(language)
        }
        
        guard !languageVolumes.isEmpty else {
            throw CustomError("Failed to find volumes for \(language). Download the glossaries from https://developer.apple.com/download/more/ and mount the disk images, then try again.")
        }
        
        return try languageVolumes.flatMap(parseVolume)
    }
    
    func parse(languages: [String]) throws -> [Entry] {
        guard let volumes = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: []) else {
            throw CustomError("Failed to mount disk image volumes.")
        }
        
        let languageVolumes = volumes
            .filter { !$0.lastPathComponent.contains("System") }
            .filter { fileURL in
                for language in languages {
                    if fileURL.lastPathComponent.lowercased() == language.lowercased() ||
                        fileURL.lastPathComponent.initials.lowercased() == language.lowercased() {
                        return true
                    }
                }
                return false
            }
        
        guard !languageVolumes.isEmpty else {
            throw CustomError("Failed to find volumes for any language in \(languages). Download the glossaries from https://developer.apple.com/download/more/ and mount the disk images, then try again.")
        }
        
        return try languageVolumes.flatMap(parseVolume)
    }
    
    // MARK: - Private
    
    private func parseVolume(at url: URL) throws -> [Entry] {
        let glossaryURLs = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
        return try glossaryURLs.flatMap { try parseDocument(at: $0, language: url.lastPathComponent) }
    }
    
    private func parseDocument(at url: URL, language: String) throws -> [Entry] {
        let document = try XMLDocument(contentsOf: url, options: [.nodePreserveWhitespace])
        guard let root = document.rootElement() else {
            throw CustomError("Invalid Glossary Format.")
        }
        
        return try root.elements(forName: "File").flatMap { file in
            try file.elements(forName: "TextItem").compactMap { element in
                try parseElement(element, at: url, language: language)
            }
        }
    }
    
    private func parseElement(_ element: XMLElement, at url: URL, language: String) throws -> Entry? {
        guard let translationSet = element.onlyChild(named: "TranslationSet"),
              let base = translationSet.onlyChild(named: "base")?.textOfOnlyChild,
              let translation = translationSet.onlyChild(named: "tran")?.textOfOnlyChild
        else {
            return nil
        }
        let comment = element.onlyChild(named: "Description")?.textOfOnlyChild
        let key = element.onlyChild(named: "Position")?.textOfOnlyChild ?? "<NO KEY>"
        
        return Entry(fileURL: url, comment: comment, key: key, base: base, translation: translation, language: language)
    }
}
