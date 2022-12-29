//
//  SceneDelegate.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var dependency: AppDependency!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.dependency = self.dependency ?? CompositionRoot.resolve(windowScene: windowScene)
        self.dependency.configureSDKs()
        self.dependency.configureAppearance()
        self.window = self.dependency.window
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) {
//        if let clipboardString = UIPasteboard.general.string {
//            NotificationCenter.default.post(
//                name: Notification.Name.changeClipboardString,
//                object: clipboardString
//            )
//        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
