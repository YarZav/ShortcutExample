import UIKit

final class IZComicViewController: UIViewController, IZPresenterProtocol, IZComicOutputProtocol {
  // MARK: - Constants

  private enum Constants {
    static let margin: CGFloat = 20
    static let imageShare = "square.and.arrow.up"
    static let starImage = "star"
    static let starFillImage = "star.fill"
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

  private var starBarButtonItem: UIBarButtonItem {
    let isFavorite = presenter.comicModel?.isFavorite ?? false
    let imageName = isFavorite ? Constants.starFillImage : Constants.starImage
    return .init(
      image: UIImage(systemName: imageName),
      style: .plain,
      target: self,
      action: #selector(didTapFavorite)
    )
  }

  private lazy var searchBar: UISearchBar = {
    let searchBar = IZSearchBar()
    searchBar.editDelegate = self
    searchBar.keyboardType = .numberPad
    return searchBar
  }()

  private lazy var button: UIButton = {
    let button = UIButton()
    button.isUserInteractionEnabled = false
    button.addTarget(self, action: #selector(didTapDetail), for: .touchUpInside)
    return button
  }()

  private lazy var imageView = IZImageView()

  private let presenter: IZComicPresenterProtocol

  // MARK: - Internal property

  var onDetail: ((IZComicModel) -> Void)?

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
    searchBar.resignFirstResponder()
    navigationItem.rightBarButtonItem = starBarButtonItem
    button.isUserInteractionEnabled = true
    imageView.load(with: url)
  }

  func startLoading() {
    navigationItem.rightBarButtonItem = nil
    button.isUserInteractionEnabled = false
    imageView.showLoading()
  }

  func stopLoading() {
    button.isUserInteractionEnabled = true
    imageView.hideLoading()
  }

  func showError() {
    navigationItem.rightBarButtonItem = nil
    button.isUserInteractionEnabled = false
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
    view.addSubview(button)

    imageView.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.margin),
      imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.margin),
      imageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Constants.margin),
      imageView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.margin),

      button.topAnchor.constraint(equalTo: imageView.topAnchor),
      button.leftAnchor.constraint(equalTo: imageView.leftAnchor),
      button.rightAnchor.constraint(equalTo: imageView.rightAnchor),
      button.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
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

  @objc
  func didTapDetail() {
    searchBar.resignFirstResponder()
    guard let model = presenter.comicModel else { return }
    onDetail?(model)
  }

  @objc
  func didTapFavorite() {
    presenter.saveAsFavorite()
    navigationItem.rightBarButtonItem = starBarButtonItem
  }
}
