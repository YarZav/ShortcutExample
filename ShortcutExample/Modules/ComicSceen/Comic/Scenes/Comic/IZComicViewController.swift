import UIKit

final class IZComicViewController: UIViewController, IZPresenterProtocol {
  // MARK: - Private property

  // MARK: - Internal property

  var presenter: IZComicPresenterProtocol

  // MARK: - Init

  init(presenter: IZComicPresenterProtocol) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life circle

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

// MARK: - IZComicViewProtocol

extension IZComicViewController: IZComicViewProtocol { }
