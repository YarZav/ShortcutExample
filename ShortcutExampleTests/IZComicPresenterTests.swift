import XCTest
@testable import ShortcutExample

final class IZComicPresenterTests: XCTest {
  // MARK: - Private property

  private var presenter: IZComicPresenter!

  // MARK: - Init

  override func setUp() {
    super.setUp()
    presenter = IZComicPresenter()
  }

  override func tearDown() {
    super.tearDown()
    presenter = nil
  }

  // MARK: - Test

  func testSaveData() {
    // given
    let model = IZComicModel(
      date: Date(),
      num: 1,
      transcript: "transcript",
      img: URL(string: "https://imgs.xkcd.com/comics/woodpecker.png"),
      title: "title"
    )
    presenter.comicModel = model

    // when
    presenter.saveAsFavorite()

    // given
    let coreData = IZCoreDataManager.shared
    let dbModels: [IZComicDBModel]? = coreData.getCoreDataModels(entityName: IZComicDBModel.entityName)
    XCTAssertEqual(dbModels?.count, 1)
  }
}
