import Foundation

final class IZFavoriteMapper: IZFavoriteMapperProtocol {
  // MARK: - IZFavoriteMapperProtocol

  func map(from dbModels: [IZComicDBModel]?) -> [IZComicModel] {
    dbModels?.compactMap { map(from: $0) } ?? []
  }
}

// MARK: - Private

private extension IZFavoriteMapper {
  func map(from dbModel: IZComicDBModel?) -> IZComicModel? {
    guard
      let numString = dbModel?.num, let num = Int(numString),
      let imgString = dbModel?.img, let url = URL(string: imgString),
      let title = dbModel?.title.nilIfEmpty
    else { return nil }
    return .init(
      date: dbModel?.date,
      num: num,
      transcript: dbModel?.transcript,
      img: url,
      title: title
    )
  }
}
