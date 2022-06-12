final class IZMainViewFactory: IZMainViewFactoryProtocol {

  // MARK: - IZMainViewFactoryProtocol

  func tabBar(comicCoordinatorFlow: IZComicCoordinator) -> IZPresenterProtocol {
    let view = IZTabBarViewController()
    view.comicViewController = comicCoordinatorFlow.getNavigationController()
    return view
  }
}
