protocol IZCoreDataModelIdentifiable {
  /// DataBase model identifier
  var id: String { get set }

  /// DataBase name
  static var entityName: String { get }
}
