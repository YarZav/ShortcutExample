import UIKit

final class IZFavoriteCoordinator: IZBaseCoordinator {
  // MARK: - Private property

  private let factory: IZFavoriteViewFactoryProtocol
  private let router: IZRouterProtocol

  // MARK: - Init

  /// Init with 'factory', 'router'
  /// - Parameters:
  ///     router: View routing
  ///     factory: View factory
  /// - Returns: Coordinator flow
  init(
    router: IZRouterProtocol,
    factory: IZFavoriteViewFactoryProtocol = IZFavoriteViewFactory()
  ) {
    self.router = router
    self.factory = factory
  }
}

// MARK: - Internal

extension IZFavoriteCoordinator {
  func getNavigationController() -> UINavigationController? {
    router.navigationController
  }
}

// MARK: - Coordinatable

extension IZFavoriteCoordinator: IZCoordinatorProtocol {
  func start() {
    favorite()
  }
}

// MARK: - Private

private extension IZFavoriteCoordinator {
  func favorite() {
    let comic = factory.favorite { [weak self] in
      self?.favoriteDetail(with: $0)
    }
    router.setRoot(comic)
  }

  func favoriteDetail(with model: IZComicModel) {
    let comic = factory.favoriteDetail(model)
    router.push(comic)
  }
}
