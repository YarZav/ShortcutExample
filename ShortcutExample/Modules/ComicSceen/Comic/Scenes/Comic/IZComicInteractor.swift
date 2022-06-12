import Foundation

final class IZComicInteractor {
  // MARK: - Constants

  private enum Constants {
    static let currentComicURLPart1 = "https://xkcd.com"
    static let currentComicURLPart2 = "info.0.json"
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
    let path = Constants.currentComicURLPart1 + "/" + Constants.currentComicURLPart2
    guard let url = URL(string: path) else {
      completion?(.failure(.unspecified(statusMessage: "Bad URL request")))
      return
    }

    let request = IZURLRequest(url: url, httpMethod: .get)
    urlSession.dataTask(with: request, completion: completion)
  }

  func search(with text: String?, completion: ((Result<Data?, IZURLError>) -> Void)?) {
    let searchText = text.map { "/" + $0 + "/" } ?? "/"
    let path = Constants.currentComicURLPart1 + searchText + Constants.currentComicURLPart2
    guard let url = URL(string: path) else {
      completion?(.failure(.unspecified(statusMessage: "Bad URL request")))
      return
    }

    let request = IZURLRequest(url: url, httpMethod: .get)
    urlSession.dataTask(with: request, completion: completion)
  }
}
