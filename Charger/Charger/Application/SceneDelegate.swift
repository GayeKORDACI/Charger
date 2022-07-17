import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        AppAppearance.setupAppearance()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureWindow(windowScene: windowScene)
    }

    private func configureWindow(windowScene: UIWindowScene) {
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = AppBootstrap.configureRoot()
        window?.makeKeyAndVisible()
    }
}
