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
        let selectKindService: SelectKindServiceType = SelectKindService()
        let selectLocationService: SelectLocationServiceType = SelectLocationService()
        
        let noteScreen = makeNoteScreen(locationService: locationService,
                                        noteService: noteService,
                                        memoNoteService: memoNoteService,
                                        urlNoteService: urlNoteService,
                                        selectKindService: selectKindService,
                                        selectLocationService: selectLocationService)
        
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
                               urlNoteService: UrlNoteServiceType,
                               selectKindService: SelectKindServiceType,
                               selectLocationService: SelectLocationServiceType) -> NoteViewController {
        let pushCreateOrUpdateNoteScreen: (_ note: Note) -> CreateOrUpdateNoteViewController = { note in
            let reactor = CreateOrUpdateNoteReactor(note: note,
                                                    noteService: noteService,
                                                    selectKindService: selectKindService)
            
            let pushSelectKindBottomSheetScreen: (Kind) -> SelectKindBottomSheetViewController = { kind in
                let reactor = SelectKindBottomSheetReactor(selectedKind: kind,
                                                           selectKindService: selectKindService)
                let viewController = SelectKindBottomSheetViewController(mode: .drag, reactor: reactor)
                
                return viewController
            }
            
            let pushSelectLocationBottomSheetScreen: (Location) -> SelectLocationBottomSheetViewController = { location in
                let reactor = SelectLocationBottomSheetReactor(selectedLocation: location,
                                                               locationService: locationService,
                                                               selectLocationService: selectLocationService)
                let viewController = SelectLocationBottomSheetViewController(mode: .drag, reactor: reactor)
                
                return viewController
            }
            
            let presentCreateOrUpdateMemoNoteView: (_ note: Note) -> CreateOrUpdateMemoNoteView = { note in
                let reactor = CreateOrUpdateMemoNoteReactor(note: note,
                                                            memoNoteService: memoNoteService)
                let view = CreateOrUpdateMemoNoteView(reactor: reactor)
                
                return view
            }
            
            let presentCreateOrUpdateUrlNoteView: (_ note: Note) -> CreateOrUpdateUrlNoteView = { note in
                let reactor = CreateOrUpdateUrlNoteReactor(note: note,
                                                           urlNoteService: urlNoteService)
                let view = CreateOrUpdateUrlNoteView(reactor: reactor)
                
                return view
            }
            
            let viewController = CreateOrUpdateNoteViewController(reactor: reactor,
                                                                  pushSelectKindBottomSheetScreen: pushSelectKindBottomSheetScreen,
                                                                  pushSelectLocationBottomSheetScreen: pushSelectLocationBottomSheetScreen,
                                                                  presentCreateMemoNoteView: presentCreateOrUpdateMemoNoteView,
                                                                  presentCreateUrlNoteView: presentCreateOrUpdateUrlNoteView)
            
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
        
        let reactor = NoteReactor(locationService: locationService,
                                  noteService: noteService)
        let viewController = NoteViewController(reactor: reactor,
                                                pushCreateNoteScreen: pushCreateOrUpdateNoteScreen,
                                                pushCopyBottomSheetScreen: pushCopyBottomSheetScreen,
                                                pushSettingScreen: pushSettingScreen)
        
        return viewController
    }
}
