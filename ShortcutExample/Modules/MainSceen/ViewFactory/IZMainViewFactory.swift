final class IZMainViewFactory: IZMainViewFactoryProtocol {

  // MARK: - IZMainViewFactoryProtocol

  func tabBar(
    comicCoordinatorFlow: IZComicCoordinator,
    favoriteCoordinatorFlow: IZFavoriteCoordinator
  ) -> IZPresenterProtocol {
    let view = IZTabBarViewController()
    view.comicViewController = comicCoordinatorFlow.getNavigationController()
    view.favoriteViewController = favoriteCoordinatorFlow.getNavigationController()
    return view
  }
}
