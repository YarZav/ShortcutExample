extension Optional where Wrapped == String {
  var nilIfEmpty: String? {
    if let text = self, !text.isEmpty {
      return text
    }
    return nil
  }
}
