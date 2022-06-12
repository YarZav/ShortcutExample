protocol IZComicViewFactoryProtocol {
  /// Displaying view
  ///
  /// - Returns: View
  func comic(_ onDetail: ((IZComicModel) -> Void)?) -> IZPresenterProtocol & IZComicOutputProtocol

  /// Displaying detail view
  ///
  /// - Returns: View
  func comicDetail(_ model: IZComicModel) -> IZPresenterProtocol
}
