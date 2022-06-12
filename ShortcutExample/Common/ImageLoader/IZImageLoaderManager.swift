import Foundation

protocol IZImageLoaderManagerProtocol {
  /// Loading image by URL
  ///
  /// - Parameters:
  ///   - url: URL with image (unfortunately iss return error with permissions access)
  ///   - complation: Completion with Result<Data, Error>
  func loadImage(with url: URL, complation: ((Result<Data?, IZURLError>) -> Void)?)
}

final class IZImageLoaderManager {
  // MARK: - Private property

  private let urlSession: IZURLSessionProtocol

  // MARK: - Init

  /// Init with urlSession wrapper
  ///
  /// - Parameters:
  ///   - urlSession: Simple URL session wrapper
  init(urlSession: IZURLSessionProtocol = IZURLSession()) {
    self.urlSession = urlSession
  }
}

// MARK: - IZImageLoaderManagerProtocol

extension IZImageLoaderManager: IZImageLoaderManagerProtocol {
  func loadImage(with url: URL, complation: ((Result<Data?, IZURLError>) -> Void)?) {
    let request = IZURLRequest(url: url, httpMethod: .get)
    urlSession.dataTask(with: request, completion: complation)
  }
}
