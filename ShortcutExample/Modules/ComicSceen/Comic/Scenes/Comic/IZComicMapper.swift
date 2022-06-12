import Foundation

final class IZComicMapper: IZComicMapperProtocol {
  // MARK: - IZComicMapperProtocol

  func map(from data: Data?) -> IZComicModel? {
    guard let data = data else { return nil }
    do {
      let apiModel = try JSONDecoder().decode(IZComicAPIModel?.self, from: data)
      return map(from: apiModel)
    } catch {
      return nil
    }
  }
}

// MARK: - Private

private extension IZComicMapper {
  func map(from apiModel: IZComicAPIModel?) -> IZComicModel? {
    guard
      let month = apiModel?.month.nilIfEmpty,
      let day = apiModel?.day.nilIfEmpty,
      let year = apiModel?.year.nilIfEmpty,
      let num = apiModel?.num,
      let img = apiModel?.img.nilIfEmpty,
      let url = URL(string: img),
      let title = apiModel?.title.nilIfEmpty
    else { return nil }
    let dateComponents = DateComponents(calendar: Calendar.current, year: Int(year), month: Int(month), day: Int(day))
    return .init(
      date: dateComponents.date,
      num: num,
      transcript: apiModel?.transcript,
      img: url,
      title: title
    )
  }
}
