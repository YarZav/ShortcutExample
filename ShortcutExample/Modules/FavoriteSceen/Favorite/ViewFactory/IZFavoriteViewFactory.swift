final class IZFavoriteViewFactory: IZFavoriteViewFactoryProtocol {
  // MARK: - IZFavoriteViewFactoryProtocol

  func favorite(_ onDetail:  ((IZComicModel) -> Void)?) -> IZPresenterProtocol & IZFavoriteOutputProtocol {
    let presenter = IZFavoritePresenter()
    let view = IZFavoriteViewController(presenter: presenter)
    presenter.view = view
    view.onDetail = onDetail
    return view
  }

  func favoriteDetail(_ model: IZComicModel) -> IZPresenterProtocol {
    IZComicDetailViewController(model: model)
  }
}
