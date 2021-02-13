extension String {
    // Adapted from https://stackoverflow.com/a/35286740
    var initials: String {
        components(separatedBy: " ")
            .reduce("") {
                $0.firstOrEmpty + $1.firstOrEmpty
            }
    }
    
    private var firstOrEmpty: String {
        if let first = first {
            return String(first)
        }
        return ""
    }
}
