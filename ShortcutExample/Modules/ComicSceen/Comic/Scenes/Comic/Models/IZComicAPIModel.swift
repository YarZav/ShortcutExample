struct IZComicAPIModel: Decodable {
  /// Month of added
  let month: String?

  /// Number of comic
  let num: Int?

  /// Web link for comic
  let link: String?

  /// Year of added
  let year: String?

  /// New about comic
  let news: String?

  /// Displayed title
  let safe_title: String?

  /// Transcript image text to string
  let transcript: String?

  ///
  let alt: String?

  /// Image link
  let img: String?

  /// Title
  let title: String?

  /// Day of added
  let day: String?
}
