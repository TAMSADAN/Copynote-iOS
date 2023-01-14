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
        
        let memoNoteService: MemoNoteServiceType = MemoNoteService()
        
        let noteScreen = makeNoteScreen(memoNoteService: memoNoteService)
        
        window.rootViewController = UINavigationController(rootViewController: noteScreen)
        return AppDependency(window: window,
                             configureSDKs: self.configureSDKs,
                             configureAppearance: self.configureAppearance)
    }

    static func configureSDKs() { }

    static func configureAppearance() { }
}

extension CompositionRoot {
    static func makeNoteScreen(memoNoteService: MemoNoteServiceType) -> NoteViewController {
        let pushCreateNoteScreen: (_ info: NoteInfo) -> CreateNoteViewController = { info in
            let reactor = CreateNoteReactor(info: info)
            let presentCreateMemoNoteView: (_ info: NoteInfo) -> CreateMemoNoteView = { info in
                let reactor = CreateMemoNoteReactor(info: info,
                                                    memoNoteService: memoNoteService)
                let view = CreateMemoNoteView(reactor: reactor)
                return view
            }
            let presentCreateUrlNoteView: (_ info: NoteInfo) -> CreateUrlNoteView = { info in
                let reactor = CreateUrlNoteReactor(info: info)
                let view = CreateUrlNoteView(reactor: reactor)
                return view
            }
            let viewController = CreateNoteViewController(reactor: reactor,
                                                          presentCreateMemoNoteView: presentCreateMemoNoteView,
                                                          presentCreateUrlNoteView: presentCreateUrlNoteView)
            
            return viewController
        }
        
        let reactor = NoteReactor()
        let viewController = NoteViewController(reactor: reactor,
                                                pushCreateNoteScreen: pushCreateNoteScreen)
        
        return viewController
    }
}
