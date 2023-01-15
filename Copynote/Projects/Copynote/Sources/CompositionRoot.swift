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
        
        let locationService: LocationServiceType = LocationService()
        let noteService: NoteServiceType = NoteService()
        let memoNoteService: MemoNoteServiceType = MemoNoteService(noteEvent: noteService.event)
        let urlNoteService: UrlNoteServiceType = UrlNoteService(noteEvent: noteService.event)
        
        let noteScreen = makeNoteScreen(locationService: locationService,
                                        noteService: noteService,
                                        memoNoteService: memoNoteService,
                                        urlNoteService: urlNoteService)
        
        window.rootViewController = UINavigationController(rootViewController: noteScreen)
        return AppDependency(window: window,
                             configureSDKs: self.configureSDKs,
                             configureAppearance: self.configureAppearance)
    }

    static func configureSDKs() { }

    static func configureAppearance() { }
}

extension CompositionRoot {
    static func makeNoteScreen(locationService: LocationServiceType,
                               noteService: NoteServiceType,
                               memoNoteService: MemoNoteServiceType,
                               urlNoteService: UrlNoteServiceType) -> NoteViewController {
        let pushCreateNoteScreen: (_ note: Note) -> CreateNoteViewController = { note in
            let reactor = CreateNoteReactor(note: note, noteService: noteService)
            let presentCreateMemoNoteView: (_ note: Note) -> CreateMemoNoteView = { note in
                let reactor = CreateMemoNoteReactor(note: note,
                                                    memoNoteService: memoNoteService)
                let view = CreateMemoNoteView(reactor: reactor)
                return view
            }
            let presentCreateUrlNoteView: (_ note: Note) -> CreateUrlNoteView = { note in
                let reactor = CreateUrlNoteReactor(note: note,
                                                   urlNoteService: urlNoteService)
                let view = CreateUrlNoteView(reactor: reactor)
                return view
            }
            let viewController = CreateNoteViewController(reactor: reactor,
                                                          presentCreateMemoNoteView: presentCreateMemoNoteView,
                                                          presentCreateUrlNoteView: presentCreateUrlNoteView)
            
            return viewController
        }
        
        let pushCopyBottomSheetScreen: (_ note: Note) -> CopyBottomSheetViewController = { note in
            let reactor = CopyBottomSheetReactor(note: note)
            let viewController = CopyBottomSheetViewController(mode: .drag,
                                                               reactor: reactor)
            
            return viewController
        }
        
        let pushSettingScreen: () -> SettingViewController = {
            let reactor = SettingReactor()
            let viewController = SettingViewController(reactor: reactor)
            
            return viewController
        }
        
        let reactor = NoteReactor(locationService: locationService, noteService: noteService)
        let viewController = NoteViewController(reactor: reactor,
                                                pushCreateNoteScreen: pushCreateNoteScreen,
                                                pushCopyBottomSheetScreen: pushCopyBottomSheetScreen,
                                                pushSettingScreen: pushSettingScreen)
        
        return viewController
    }
}
