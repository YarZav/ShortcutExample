import UIKit

@main
final class AppDelegate: UIResponder {
  /// App window
  private let window = UIWindow(frame: UIScreen.main.bounds)

  /// App configuration to coordinate into first screen
  private let appConfiguration: IZAppConfigurationProtocol = IZAppConfiguration()
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    window.rootViewController = appConfiguration.coordinatorFlow.getNavigationController()
    window.makeKeyAndVisible()
    return true
  }
}
