final class IZComicViewFactory: IZComicViewFactoryProtocol {
  // MARK: - IZComicViewFactoryProtocol

  func comic(_ onDetail: ((IZComicModel) -> Void)?) -> IZPresenterProtocol & IZComicOutputProtocol {
    let presenter = IZComicPresenter()
    let view = IZComicViewController(presenter: presenter)
    view.onDetail = onDetail
    presenter.view = view
    return view
  }

  func comicDetail(_ model: IZComicModel) -> IZPresenterProtocol {
    IZComicDetailViewController(model: model)
  }
}
