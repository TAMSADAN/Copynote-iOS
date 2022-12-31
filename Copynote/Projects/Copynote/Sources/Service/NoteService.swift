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
    case createNote(Note)
    case updateNote(Note)
    case deleteNote(Note)
}

protocol NoteServiceType {
    var event: PublishSubject<NoteEvent> { get }
    
    func createUrlNote(note: UrlNote)
    func createMemoNote(note: MemoNote)
    func updateUrlNote(note: UrlNote)
    func deleteUrlNote(id: String)
    func deleteMemoNote(id: String)
}

class NoteService: NoteServiceType {
    var event = PublishSubject<NoteEvent>()
    
    let realm = Provider.shared.realm
    
    func createUrlNote(note: UrlNote) {
        try! realm.write {
            let obj = note.toRealm()
            obj.id = UUID().uuidString
            
            realm.add(obj)
            event.onNext(.createNote(note.toNote()))
        }
    }
    
    func createMemoNote(note: MemoNote) {
        try! realm.write {
            let obj = note.toRealm()
            obj.id = UUID().uuidString
            
            realm.add(obj)
            event.onNext(.createNote(note.toNote()))
        }
    }
    
    func updateUrlNote(note: UrlNote) {
        
    }
    
    func deleteMemoNote(id: String) {
        guard let obj = realm.objects(MemoNoteRealm.self).where({ $0.id == id }).first else {
            return
        }
        
        try! realm.write {
            realm.delete(obj)
            event.onNext(.deleteNote(obj.toDomain().toNote()))
        }
    }
    
    func deleteUrlNote(id: String) {
        guard let obj = realm.objects(UrlNoteRealm.self).where({ $0.id == id }).first else {
            return
        }
        
        try! realm.write {
            realm.delete(obj)
            event.onNext(.deleteNote(obj.toDomain().toNote()))
        }
    }
}
