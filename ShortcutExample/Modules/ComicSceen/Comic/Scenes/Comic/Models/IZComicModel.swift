import Foundation

final class IZComicModel {
  /// Unique identifier
  var id: String { String(num) }

  /// Month of added
  let date: Date?

  /// Number of comic
  let num: Int

  /// Transcript image text to string
  let transcript: String?

  /// Image link
  let img: URL?

  /// Title
  let title: String

  /// Is added to favorite
  var isFavorite: Bool = false

  // MARK: - Init

  init(
    date: Date?,
    num: Int,
    transcript: String?,
    img: URL?,
    title: String
  ) {
    self.date = date
    self.num = num
    self.transcript = transcript
    self.img = img
    self.title = title
  }
}
