protocol IZFavoriteViewFactoryProtocol {
  /// Displaying view
  ///
  /// - Returns: View
  func favorite(_ onDetail:  ((IZComicModel) -> Void)?) -> IZPresenterProtocol & IZFavoriteOutputProtocol

  /// Displaying detail view
  ///
  /// - Returns: View
  func favoriteDetail(_ model: IZComicModel) -> IZPresenterProtocol
}
