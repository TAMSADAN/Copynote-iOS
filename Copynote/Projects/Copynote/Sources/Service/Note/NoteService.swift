//
//  NoteService.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/31.
//  Copyright © 2022 Copynote. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

enum NoteEvent {
    case fetchNotes([Note])
    case fetchNote(Note)
    case createOrUpdateNote(Note)
    case deleteNote(Note)
}

protocol NoteServiceType {
    var event: PublishSubject<NoteEvent> { get }
    
    func fetchNotes()
}

class NoteService: NoteServiceType {
    var event = PublishSubject<NoteEvent>()
    let realm = Provider.shared.realm
    
    func fetchNotes() {
        let objs = realm.objects(NoteRealm.self).map{ $0.toDomain() }
        
        event.onNext(.fetchNotes(Array(objs)))
    }
}
