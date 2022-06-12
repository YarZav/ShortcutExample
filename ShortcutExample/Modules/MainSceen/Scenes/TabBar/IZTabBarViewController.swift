import UIKit

final class IZTabBarViewController: UITabBarController, IZPresenterProtocol {
  // MARK: - Constants

  private enum Constants {
    static let comicText = NSLocalizedString("ComicKey", comment: "")
    static let comicImageName = ""
  }

  // MARK: - Internal property

  var comicViewController: UIViewController?

  // MARK: - Life circle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.createUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateUI()
  }
}

// MARK: - Private

private extension IZTabBarViewController {
  func createUI() {
    view.backgroundColor = .systemBackground
    delegate = self
  }

  func updateUI() {
    tabBar.unselectedItemTintColor = .black
    tabBar.tintColor = .systemYellow
    navigationController?.setNavigationBarHidden(true, animated: false)
    addTabBarItem(for: comicViewController, title: Constants.comicText, imageName: Constants.comicImageName)
    viewControllers = [comicViewController].compactMap { $0 }
  }

  func addTabBarItem(
    for viewController: UIViewController?,
    title: String,
    imageName: String
  ) {
    guard let viewController = viewController else { return }
    let tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageName), selectedImage: nil)
    viewController.tabBarItem = tabBarItem
  }
}

// MARK: - IZTabBarViewProtocol

extension IZTabBarViewController: IZTabBarViewProtocol {
  func reloadBadge(_ count: Int) {
    tabBar.items?.last?.badgeValue = "\(count)"
    tabBar.items?.last?.badgeColor = .systemYellow
  }
}

// MARK: - UITabBarControllerDelegate

extension IZTabBarViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    return true
  }
}
