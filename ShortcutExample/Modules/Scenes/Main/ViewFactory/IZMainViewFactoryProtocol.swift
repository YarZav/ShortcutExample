protocol IZMainViewFactoryProtocol {
  /// Displaying view with TabBar
  ///
  /// - Parameters:
  ///   - productListCoordinatorFlow: Product list coordinator flow
  /// - Returns: View
  func tabBar() -> IZPresenterProtocol
}
