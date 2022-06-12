import Foundation

final class IZFavoritePresenter {
  // MARK: - Private property

  private let interactor: IZFavoriteInteractorProtocol
  private let mapper: IZFavoriteMapperProtocol

  // MARK: - Internal property

  weak var view: IZFavoriteViewProtocol?
  var favorites: [IZComicModel] = []

  // MARK: - Init

  /// Init with 'interactor',  'mapper'
  ///
  /// - Parameters:
  ///   - interactor: Interactor layer
  ///   - mapper: Mapper layer
  init(
    interactor: IZFavoriteInteractorProtocol = IZFavoriteInteractor(),
    mapper: IZFavoriteMapperProtocol = IZFavoriteMapper()
  ) {
    self.interactor = interactor
    self.mapper = mapper
  }
}

// MARK: - IZComicPresenterProtocol

extension IZFavoritePresenter: IZFavoritePresenterProtocol {
  func viewWillApear() {
    let dbModels = interactor.favorites()
    favorites = mapper.map(from: dbModels)
    favorites.isEmpty ? view?.showEmpty() : view?.reloadData()
  }
}
