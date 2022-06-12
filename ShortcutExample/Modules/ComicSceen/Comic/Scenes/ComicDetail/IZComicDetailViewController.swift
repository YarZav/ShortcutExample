import UIKit

final class IZComicDetailViewController: UIViewController, IZPresenterProtocol {
  // MARK: - Constants

  private enum Constants {
    static let margin: CGFloat = 20
  }

  // MARK: - Private property

  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    model.date.map {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "YY MMMM dd"
      label.text = dateFormatter.string(from: $0)
    }
    label.font = .systemFont(ofSize: 15)
    return label
  }()

  private lazy var transcriptLabel: UILabel = {
    let label = UILabel()
    label.text = model.transcript
    label.font = .systemFont(ofSize: 13)
    label.numberOfLines = 3
    return label
  }()

  private lazy var imageView: UIView = {
    let imageView = IZImageView()
    imageView.load(with: model.img)
    return imageView
  }()

  private let model: IZComicModel

  // MARK: - Init

  init(model: IZComicModel) {
    self.model = model
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
}

// MARK: - IZComicDetailViewProtocol

extension IZComicDetailViewController: IZComicDetailViewProtocol { }

// MARK: - Private

private extension IZComicDetailViewController {
  func setUp() {
    view.backgroundColor = .white
    title = model.title

    view.addSubview(dateLabel)
    view.addSubview(transcriptLabel)
    view.addSubview(imageView)

    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    transcriptLabel.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.margin),
      dateLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.margin),
      dateLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Constants.margin),

      transcriptLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: Constants.margin),
      transcriptLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.margin),
      transcriptLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Constants.margin),


      imageView.topAnchor.constraint(equalTo: transcriptLabel.topAnchor, constant: Constants.margin),
      imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.margin),
      imageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Constants.margin),
      imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.margin),
    ])
  }
}
