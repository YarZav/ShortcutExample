final class IZComicPresenter {
  // MARK: - Private property

  private let interactor: IZComicInteractorProtocol
  private let mapper: IZComicMapperProtocol

  // MARK: - Internal property

  weak var view: IZComicViewProtocol?

  // MARK: - Init

  /// Init with 'interactor',  'mapper'
  ///
  /// - Parameters:
  ///   - interactor: Interactor layer
  ///   - mapper: Mapper layer
  init(
    interactor: IZComicInteractorProtocol = IZComicInteractor(),
    mapper: IZComicMapperProtocol = IZComicMapper()
  ) {
    self.interactor = interactor
    self.mapper = mapper
  }
}

// MARK: - IZComicPresenterProtocol

extension IZComicPresenter: IZComicPresenterProtocol { }
