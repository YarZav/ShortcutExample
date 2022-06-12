import Foundation
import CoreData

final class IZComicInteractor {
  // MARK: - Constants

  private enum Constants {
    static let currentComicURLPart1 = "https://xkcd.com"
    static let currentComicURLPart2 = "info.0.json"
  }

  // MARK: - Private property

  private let urlSession: IZURLSessionProtocol
  private let coreData: IZCoreDataManager

  // MARK: - Init

  init(
    urlSession: IZURLSessionProtocol = IZURLSession(),
    coreData: IZCoreDataManager = IZCoreDataManager.shared
  ) {
    self.urlSession = urlSession
    self.coreData = coreData
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

  func saveAsFavorite(_ comic: IZComicModel) {
    isFavorite(comic) ? delete(comic) : save(comic)
  }

  func isFavorite(_ comic: IZComicModel) -> Bool {
    let models: [IZComicDBModel]? = coreData.getCoreDataModels(entityName: IZComicDBModel.entityName)
    return models?.contains(where: { $0.id == comic.id }) ?? false
  }
}

// MARK: - Private

private extension IZComicInteractor {
  func save(_ comic: IZComicModel) {
    let dbModel = IZComicDBModel()
    dbModel.id = comic.id
    dbModel.date = comic.date
    dbModel.num = String(comic.num)
    dbModel.title = comic.title
    dbModel.transcript = comic.transcript
    dbModel.img = comic.img?.absoluteString
    coreData.saveContext { _ in }
  }

  func delete(_ comic: IZComicModel) {
    let models: [IZComicDBModel]? = coreData.getCoreDataModels(entityName: IZComicDBModel.entityName)
    let model = models?.first(where: { $0.id == comic.id })
    guard let previousCoreDataModel = model else { return  }
    coreData.managedObjectContext.delete(previousCoreDataModel)
    coreData.saveContext { _ in }
  }
}
