protocol IZCoordinatorFactoryProtocol {
  /// Coordinator flow
  ///
  /// - Parameters:
  ///     - router:  Router for moving in stack of views
  func mainCoordinator(
    router: IZRouterProtocol
  ) -> IZCoordinatorProtocol
}
