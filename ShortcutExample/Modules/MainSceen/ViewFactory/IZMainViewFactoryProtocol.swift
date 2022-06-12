protocol IZMainViewFactoryProtocol {
  /// Displaying view with TabBar
  ///
  /// - Parameters:
  ///   - comicCoordinatorFlow: Comic coordinator flow
  ///   - favoriteCoordinatorFlow: Favorite coordinator flow
  /// - Returns: View
  func tabBar(
    comicCoordinatorFlow: IZComicCoordinator,
    favoriteCoordinatorFlow: IZFavoriteCoordinator
  ) -> IZPresenterProtocol
}
