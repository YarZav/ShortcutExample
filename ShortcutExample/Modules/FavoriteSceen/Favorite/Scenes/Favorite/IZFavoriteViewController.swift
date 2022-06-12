import UIKit

final class IZFavoriteViewController: UIViewController, IZPresenterProtocol, IZFavoriteOutputProtocol {

  // MARK: - Constants

  private enum Constants {
    static let margin: CGFloat = 20
    static let titleText = NSLocalizedString("FavoriteKey", comment: "")
    static let emptyImageName = "empty"
  }

  // MARK: - Private property

  lazy var imageSize: CGFloat = {
    (view.frame.size.width - Constants.margin * 3) / 2
  }()

  private lazy var layout: UICollectionViewFlowLayout = {
    let size = CGSize(width: imageSize, height: imageSize)
    let layout = UICollectionViewFlowLayout(
      itemSize: size,
      scrollDirection: .vertical,
      edgeInsets: .zero
    )
    layout.minimumInteritemSpacing = Constants.margin
    layout.minimumLineSpacing = Constants.margin
    return layout
  }()

  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      cells: [IZFavoriteCollectionCell.self],
      dataSource: self,
      delegate: self,
      layout: layout
    )
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.alwaysBounceHorizontal = false
    collectionView.backgroundColor = .white
    collectionView.dragInteractionEnabled = true
    collectionView.contentInset = .init(
      top: Constants.margin,
      left: Constants.margin,
      bottom: Constants.margin,
      right: Constants.margin
    )
    return collectionView
  }()

  private lazy var emptyView: UIImageView = {
    let image = UIImage(named: Constants.emptyImageName)
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let presenter: IZFavoritePresenterProtocol

  // MARK: - Internal

  var onDetail: ((IZComicModel) -> Void)?

  // MARK: - Init

  init(presenter: IZFavoritePresenterProtocol) {
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
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.viewWillApear()
  }
}

// MARK: - IZComicViewProtocol

extension IZFavoriteViewController: IZFavoriteViewProtocol {
  func reloadData() {
    emptyView.isHidden = true
    collectionView.reloadData()
  }

  func showEmpty() {
    emptyView.isHidden = false
    collectionView.reloadData()
  }
}

// MARK: - Private

private extension IZFavoriteViewController {
  func setUp() {
    title = Constants.titleText

    view.addSubview(collectionView)
    view.addSubview(emptyView)

    collectionView.translatesAutoresizingMaskIntoConstraints = false
    emptyView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),

      emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      emptyView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      emptyView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
  }
}

extension IZFavoriteViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    presenter.favorites.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: IZFavoriteCollectionCell = collectionView.dequeueCell(indexPath: indexPath)
    cell.favorite = presenter.favorites[indexPath.row]
    return cell
  }
}

extension IZFavoriteViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    onDetail?(presenter.favorites[indexPath.row])
  }
}
