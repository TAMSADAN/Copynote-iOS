//
//  CompositionRoot.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit

struct AppDependency {
    let window: UIWindow
    let configureSDKs: () -> Void
    let configureAppearance: () -> Void
}

class CompositionRoot {
    static func resolve(windowScene: UIWindowScene) -> AppDependency {
        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: makeNoteScreen())
        return AppDependency(window: window,
                             configureSDKs: self.configureSDKs,
                             configureAppearance: self.configureAppearance)
    }

    static func configureSDKs() { }

    static func configureAppearance() { }
}

extension CompositionRoot {
    static func makeNoteScreen() -> NoteViewController {
        let pushCreateNoteScreen: (_ mode: PresentMode, _ info: NoteInfo) -> CreateNoteViewController = { mode, info in
            let reactor = CreateNoteReactor(info: info)
            let viewController = CreateNoteViewController(mode: mode,
                                                          reactor: reactor)
            return viewController
        }
        
        let reactor = NoteReactor()
        let viewController = NoteViewController(reactor: reactor,
                                                pushCreateNoteScreen: pushCreateNoteScreen)
        
        return viewController
    }
}
