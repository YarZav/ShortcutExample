import UIKit

final class IZMainCoordinator: IZBaseCoordinator {
  // MARK: - Private property

  private let factory: IZMainViewFactoryProtocol
  private let router: IZRouterProtocol

  // MARK: - Init

  /// Init with 'factory', 'router'
  /// - Parameters:
  ///     router: View routing
  ///     factory: View factory
  /// - Returns: Coordinator flow
  init(
    router: IZRouterProtocol,
    factory: IZMainViewFactoryProtocol = IZMainViewFactory()
  ) {
    self.router = router
    self.factory = factory
  }
}

// MARK: - Coordinatable

extension IZMainCoordinator: IZCoordinatorProtocol {
  func start() {
    tabBar()
  }
}

// MARK: - Private

private extension IZMainCoordinator {
  func tabBar() {
    let tabBar = factory.tabBar()
    router.push(tabBar, animated: true)
  }
}
