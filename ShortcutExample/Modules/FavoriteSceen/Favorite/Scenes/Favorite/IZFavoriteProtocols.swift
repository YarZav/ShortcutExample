protocol IZFavoriteOutputProtocol {
  // Did tap on comic detail
  var onDetail: ((IZComicModel) -> Void)? { get set }
}

// VIEW -> PRESENTER
protocol IZFavoritePresenterProtocol {
  /// Favorite comics
  var favorites: [IZComicModel] { get }

  /// Load favorite comics
  func viewWillApear()
}

// PRESENTER -> VIEW
protocol IZFavoriteViewProtocol: AnyObject {
  /// Reload favorite comics
  func reloadData()

  /// Show empty data
  func showEmpty()
}

// PRESENTER -> MAPPER
protocol IZFavoriteMapperProtocol {
  /// Map DB mdoels to business models
  func map(from dbModels: [IZComicDBModel]?) -> [IZComicModel]
}

// INTERACTOR -> PRESENTER
protocol IZFavoriteInteractorProtocol {
  /// Get favoritrs comic from data base
  func favorites() -> [IZComicDBModel]?
}
