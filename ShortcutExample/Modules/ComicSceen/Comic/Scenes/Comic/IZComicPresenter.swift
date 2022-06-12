import Foundation

final class IZComicPresenter {
  // MARK: - Private property

  private let interactor: IZComicInteractorProtocol
  private let mapper: IZComicMapperProtocol

  private let searchBuffer = IZSearchBuffer(queue: .main)

  // MARK: - Internal property

  weak var view: IZComicViewProtocol?
  var comicModel: IZComicModel?

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

extension IZComicPresenter: IZComicPresenterProtocol {
  func viewDidLoad() {
    view?.startLoading()
    interactor.loadCurrentComic { [weak self] result in
      DispatchQueue.main.async {
        self?.loadComicResult(result)
      }
    }
  }

  func viewDidSearch(with text: String) {
    view?.startLoading()
    interactor.search(with: text) { [weak self] result in
      DispatchQueue.main.async {
        self?.loadComicResult(result)
      }
    }
  }

  func search(by text: String?) {
    searchBuffer.searchBy(text: text) { [weak self] in
      if let searchText = $0.nilIfEmpty {
        self?.viewDidSearch(with: searchText)
      } else {
        self?.viewDidLoad()
      }
    }
  }

  func saveAsFavorite() {
    guard let comic = self.comicModel else { return }
    interactor.saveAsFavorite(comic)
    comic.isFavorite = !comic.isFavorite
  }
}

// MARK: - Private

private extension IZComicPresenter {
  func loadComicResult(_ result: Result<Data?, IZURLError>) {
    switch result {
    case .success(let data):
      loadComicValue(data)
    case .failure:
      loadComicError()
    }
  }

  func loadComicValue(_ data: Data?) {
    comicModel = mapper.map(from: data)
    if let model = comicModel {
      comicModel?.isFavorite = interactor.isFavorite(model)
    }
    view?.startLoading(with: comicModel?.img)
  }

  func loadComicError() {
    view?.stopLoading()
    view?.showError()
  }
}
