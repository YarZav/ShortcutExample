import UIKit

final class IZImageView: UIView {
  // MARK: - Constants

  private enum Constants {
    static let emptyImageName = "empty"
    static let margin: CGFloat = 20
  }

  // MARK: - Private property

  private let imageManager: IZImageLoaderManagerProtocol = IZImageLoaderManager()

  private lazy var activityIndicatorView = UIActivityIndicatorView(style: .medium)
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 20
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    createUI()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private

private extension IZImageView {
  func createUI() {
    addSubview(imageView)
    addSubview(activityIndicatorView)

    imageView.translatesAutoresizingMaskIntoConstraints = false
    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      imageView.leftAnchor.constraint(equalTo: leftAnchor),
      imageView.rightAnchor.constraint(equalTo: rightAnchor),

      activityIndicatorView.topAnchor.constraint(equalTo: topAnchor),
      activityIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
      activityIndicatorView.leftAnchor.constraint(equalTo: leftAnchor),
      activityIndicatorView.rightAnchor.constraint(equalTo: rightAnchor)
    ])
  }

  func loadReceiveCompeltion(_ completion: Result<Data?, IZURLError>) {
    hideLoading()
    switch completion {
    case .success(let data):
      guard let data = data else { return }
      imageView.image = UIImage(data: data)
    case .failure:
      showEmpty()
    }
  }
}

// MARK: - Internal

extension IZImageView {
  func load(with url: URL?) {
    guard let url = url else {
      showEmpty()
      return
    }

    showLoading()
    imageManager.loadImage(
      with: url,
      complation: { [weak self] result in
        DispatchQueue.main.async { self?.loadReceiveCompeltion(result) } }
    )
  }

  func showLoading() {
    imageView.image = nil
    imageView.backgroundColor = .systemGray6
    activityIndicatorView.startAnimating()
  }

  func hideLoading() {
    imageView.backgroundColor = .clear
    activityIndicatorView.stopAnimating()
  }

  func showEmpty() {
    imageView.image = UIImage(named: Constants.emptyImageName)
  }

  var image: UIImage? {
    imageView.image
  }
}

