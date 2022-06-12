protocol IZMainViewFactoryProtocol {
  /// Displaying view with TabBar
  ///
  /// - Parameters:
  ///   - comicCoordinatorFlow: Comic coordinator flow
  /// - Returns: View
  func tabBar(comicCoordinatorFlow: IZComicCoordinator) -> IZPresenterProtocol
}
