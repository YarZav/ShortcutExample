import UIKit

final class IZMainCoordinator: IZBaseCoordinator {
  // MARK: - Private property

  private let factory: IZMainViewFactoryProtocol
  private let router: IZRouterProtocol

  /// Corodiantor flow for comic (left TabBar item)
  private lazy var comicCoordinatorFlow: IZComicCoordinator = {
    let coordinatorFlow = IZComicCoordinator(router: createNewRouter())
    addAndStartCoordinator(coordinatorFlow)
    return coordinatorFlow
  }()


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
  func createNewRouter() -> IZRouterProtocol {
    let navigationController = UINavigationController()
    return IZRouter(rootController: navigationController)
  }

  func addAndStartCoordinator(_ coordinator: IZCoordinatorProtocol) {
    addDependency(coordinator)
    coordinator.start()
  }

  func tabBar() {
    let tabBar = factory.tabBar(comicCoordinatorFlow: comicCoordinatorFlow)
    router.push(tabBar, animated: true)
  }
}
