final class IZComicViewFactory: IZComicViewFactoryProtocol {
  // MARK: - IZComicViewFactoryProtocol

  func comic() -> IZPresenterProtocol {
    let presenter = IZComicPresenter()
    let view = IZComicViewController(presenter: presenter)
    presenter.view = view
    return view
  }
}
