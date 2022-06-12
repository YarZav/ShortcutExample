import UIKit

final class IZComicViewController: UIViewController, IZPresenterProtocol {
  // MARK: - Constants

  private enum Constants {
    static let margin: CGFloat = 20
    static let imageShare = "square.and.arrow.up"
  }

  // MARK: - Private property

  private lazy var shareBarButtonItem: UIBarButtonItem = {
    .init(
      image: UIImage(systemName: Constants.imageShare),
      style: .plain,
      target: self,
      action: #selector(didShare)
    )
  }()

  private lazy var searchBar: UISearchBar = {
    let searchBar = IZSearchBar()
    searchBar.editDelegate = self
    searchBar.keyboardType = .numberPad
    return searchBar
  }()

  private lazy var imageView = IZImageView()

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
    setUp()
    presenter.viewDidLoad()
  }
}

// MARK: - IZComicViewProtocol

extension IZComicViewController: IZComicViewProtocol {
  func startLoading(with url: URL?) {
    imageView.load(with: url)
  }

  func startLoading() {
    imageView.showLoading()
  }

  func stopLoading() {
    imageView.hideLoading()
  }

  func showError() {
    imageView.showEmpty()
  }
}

// MARK: - Private

private extension IZComicViewController {
  func setUp() {
    createNavigationItem()
    createImageView()
  }

  func createNavigationItem() {
    navigationItem.titleView = searchBar
    navigationItem.leftBarButtonItem = shareBarButtonItem
  }

  func createImageView() {
    view.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.margin),
      imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.margin),
      imageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Constants.margin),
      imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.margin),
    ])
  }
}

// MARK: - IZSearchBarDelegate

extension IZComicViewController: IZSearchBarDelegate {
  func search(by text: String) {
    presenter.search(by: text)
  }
}

// MARK: - Action

private extension IZComicViewController {
  @objc
  func didShare() {
    guard let image = imageView.image else { return }
    let imageToShare = [image]
    let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = view
    present(activityViewController, animated: true, completion: nil)
  }
}
