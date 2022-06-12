final class IZCoordinatorFactory: IZCoordinatorFactoryProtocol {
  // MARK: - YZCoordinatorFactoryProtocol

  func mainCoordinator(
    router: IZRouterProtocol
  ) -> IZCoordinatorProtocol {
    IZMainCoordinator(router: router)
  }
}
