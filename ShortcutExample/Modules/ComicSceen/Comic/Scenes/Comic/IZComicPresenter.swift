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
        self?.loadCurrentComicResult(result)
      }
    }
  }

  func viewDidSearch(with text: String) {
    view?.startLoading()
    interactor.search(with: text) { [weak self] result in
      DispatchQueue.main.async {
        self?.loadCurrentComicResult(result)
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
}

// MARK: - Private

private extension IZComicPresenter {
  func loadCurrentComicResult(_ result: Result<Data?, IZURLError>) {
    switch result {
    case .success(let data):
      loadCurentComicValue(data)
    case .failure:
      loadCurentComicError()
    }
  }

  func loadCurentComicValue(_ data: Data?) {
    comicModel = mapper.map(from: data)
    view?.startLoading(with: comicModel?.img)
  }

  func loadCurentComicError() {
    view?.stopLoading()
    view?.showError()
  }
}
