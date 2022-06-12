final class IZMainViewFactory: IZMainViewFactoryProtocol {

  // MARK: - IZMainViewFactoryProtocol

  func tabBar() -> IZPresenterProtocol {
    IZTabBarViewController()
  }
}
