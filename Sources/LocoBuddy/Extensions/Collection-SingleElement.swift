extension Collection {
    /// The only element in the collection, or `nil` if there are multiple or zero elements.
    var single: Element? { count == 1 ? first : nil }
}
