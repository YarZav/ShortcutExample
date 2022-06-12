import Foundation
import CoreData

final class IZFavoriteInteractor {

  // MARK: - Private property

  private let coreData: IZCoreDataManager

  // MARK: - Init

  init(coreData: IZCoreDataManager = IZCoreDataManager.shared) {
    self.coreData = coreData
  }
}

// MARK: - IZFavoriteInteractorProtocol

extension IZFavoriteInteractor: IZFavoriteInteractorProtocol {
  func favorites() -> [IZComicDBModel]? {
    let models: [IZComicDBModel]? = coreData.getCoreDataModels(entityName: IZComicDBModel.entityName)
    return models
  }
}
