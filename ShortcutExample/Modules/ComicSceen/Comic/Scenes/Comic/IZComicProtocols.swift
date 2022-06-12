import Foundation

protocol IZComicOutputProtocol {
  // Did tap on comic detail
  var onDetail: ((IZComicModel) -> Void)? { get set }
}

// VIEW -> PRESENTER
protocol IZComicPresenterProtocol {
  /// Comic model
  var comicModel: IZComicModel? { get }

  /// Initial view did load
  func viewDidLoad()

  /// Search comic by search text
  func search(by text: String?)

  /// Set/unset as favorite
  func saveAsFavorite()
}

// PRESENTER -> VIEW
protocol IZComicViewProtocol: AnyObject {
  /// Start loading image with URL
  func startLoading(with url: URL?)

  /// Show loading indicator
  func startLoading()

  /// Hide loading indicator
  func stopLoading()

  /// Show error view
  func showError()
}

// PRESENTER -> MAPPER
protocol IZComicMapperProtocol {
  /// Map API data to business model
  func map(from data: Data?) -> IZComicModel?
}

// INTERACTOR -> PRESENTER
protocol IZComicInteractorProtocol {
  /// Load current comic
  func loadCurrentComic(_ completion: ((Result<Data?, IZURLError>) -> Void)?)

  /// Search comic
  func search(with text: String?, completion: ((Result<Data?, IZURLError>) -> Void)?)

  /// Set/unset comic as favorite
  func saveAsFavorite(_ comic: IZComicModel)

  /// Check is comic favorite
  func isFavorite(_ comic: IZComicModel) -> Bool
}
