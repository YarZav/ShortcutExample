import Foundation

final class IZComicInteractor {
  // MARK: - Constants

  private enum Constants {
    static let currentComicURLString = "https://xkcd.com/info.0.json"
  }

  // MARK: - Private property

  private let urlSession: IZURLSessionProtocol

  // MARK: - Init

  init(urlSession: IZURLSessionProtocol = IZURLSession()) {
    self.urlSession = urlSession
  }
}

// MARK: - IZComicInteractorProtocol

extension IZComicInteractor: IZComicInteractorProtocol {
  func loadCurrentComic(_ completion: ((Result<Data?, IZURLError>) -> Void)?) {
    guard let url = URL(string: Constants.currentComicURLString) else {
      completion?(.failure(.unspecified(statusMessage: "Bad URL request")))
      return
    }

    let request = IZURLRequest(url: url, httpMethod: .get)
    urlSession.dataTask(with: request, completion: completion)
  }
}
