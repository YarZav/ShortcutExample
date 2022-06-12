import Foundation

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

extension IZComicPresenter: IZComicPresenterProtocol {
  func viewDidLoad() {
    view?.startLoading()
    interactor.loadCurrentComic { [weak self] result in
      DispatchQueue.main.async {
        self?.loadCurrentComicResult(result)
      }
    }
  }

  func search(by text: String?) {
    
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
    let model = mapper.map(from: data)
    view?.startLoading(with: model?.img)
  }

  func loadCurentComicError() {
    view?.stopLoading()
    view?.showError()
  }
}
