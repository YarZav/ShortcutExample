import Foundation

// VIEW -> PRESENTER
protocol IZComicPresenterProtocol {
  /// Initial view did load
  func viewDidLoad()

  /// Search comic by search text
  func search(by text: String?)
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
}
