import UIKit

final class IZComicCoordinator: IZBaseCoordinator {
  // MARK: - Private property

  private let factory: IZComicViewFactoryProtocol
  private let router: IZRouterProtocol

  // MARK: - Init

  /// Init with 'factory', 'router'
  /// - Parameters:
  ///     router: View routing
  ///     factory: View factory
  /// - Returns: Coordinator flow
  init(
    router: IZRouterProtocol,
    factory: IZComicViewFactoryProtocol = IZComicViewFactory()
  ) {
    self.router = router
    self.factory = factory
  }
}

// MARK: - Internal

extension IZComicCoordinator {
  func getNavigationController() -> UINavigationController? {
    router.navigationController
  }
}

// MARK: - Coordinatable

extension IZComicCoordinator: IZCoordinatorProtocol {
  func start() {
    comic()
  }
}

// MARK: - Private

private extension IZComicCoordinator {
  func comic() {
    let comic = factory.comic { [weak self] in
      self?.comicDetail(with: $0)
    }
    router.setRoot(comic)
  }

  func comicDetail(with model: IZComicModel) {
    let comic = factory.comicDetail(model)
    router.push(comic)
  }
}
